#!/bin/bash

set -e

DATAPUB_APP=${1-'https://github.com/datopian/datapub'}
DATAPUB_VERSION=${2-'master'}

# CKAN <= 2.8
TAG=${3-'webassets'}
UPLOAD_MODULE_PATH=ckanext/datapub/templates/blob_storage/snippets/upload_module

echo "Removing old datapub directory..."
rm -rf datapub

if [[ $DATAPUB_APP == http* ]] ;
then
    echo "Cloning git repo, targetting $DATAPUB_VERSION..."
    git clone --branch $DATAPUB_VERSION $DATAPUB_APP datapub
else
    echo "Copying local folder..."
    cp -R $DATAPUB_APP datapub
fi

echo "Building datapub..."
cd datapub
npm install . && npm run build

if [ $TAG = 'resources' ]
then
  # CKAN < 2.8

  echo "Creating fanstatic resource tags..."
  for x in $(ls build/static/js/*.js build/static/css/*.css); do
    bundles=$bundles"\{\% resource \"${x}\" \%\}"\\n
  done
else
  # CKAN >= 2.9

  echo "Creating webassets asset tags..."
  assets="datapub/datapub-js datapub/datapub-css"
  for x in $assets; do
    bundles=$bundles"\{\% asset \"${x}\" \%\}"\\n
  done

fi

cd ..

echo "Updating upload_module.html template..."
export ASSETS=$(python -c "import sys;print(sys.argv[1].replace('build/static','datapub'))" "$bundles")
bash templater.sh ${UPLOAD_MODULE_PATH}.template > ${UPLOAD_MODULE_PATH}.html

echo "Updating assets ..."
rm -f ckanext/datapub/webassets/js/*.*
rm -f ckanext/datapub/webassets/css/*.*
cp -r datapub/build/static/* ckanext/datapub/webassets/

echo "Done!"
