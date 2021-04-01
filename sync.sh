#!/bin/bash

DATAPUB_APP=${1:='https://github.com/datopian/datapub'}
DATAPUB_VERSION=${2:='master'}
TAG=${3:='resource'}
UPLOAD_MODULE_PATH=ckanext/datapub/templates/blob_storage/snippets/upload_module

git clone --branch $DATAPUB_VERSION $DATAPUB_APP datapub
wget https://raw.githubusercontent.com/johanhaleby/bash-templater/master/templater.sh

cd datapub
npm install . && npm run build

if [ $TAG = 'webasset' ]
then
  for x in "datapub/datapub-js datapub/datapub-css"; do
    bundles=$bundles"\{\% asset \"${x}\" \%\}"\\n
  done
else
  for x in $(ls build/static/js/*.js build/static/css/*.css); do
    bundles=$bundles"\{\% resource \"${x}\" \%\}"\\n
  done
fi

cp -r build/static/* ../ckanext/datapub/fanstatic/
cd ..

export RESOURCES=$(python -c "import sys;print(sys.argv[1].replace('build/static','datapub'))" "$bundles")
bash templater.sh ${UPLOAD_MODULE_PATH}.template > ${UPLOAD_MODULE_PATH}.html
