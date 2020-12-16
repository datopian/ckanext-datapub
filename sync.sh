#!/bin/bash

DATAPUB_APP=datapub-gdx
DATAPUB_REPO=https://github.com/datopian/$DATAPUB_APP
DATAPUB_VERSION=v0.0.26

if [ ! -d datapub-gdx ]; then
    git clone --branch $DATAPUB_VERSION $DATAPUB_APP datapub-gdx
else
    cd datapub-gdx
    git fetch
    git checkout $DATAPUB_VERSION
    cd -
fi

if [ ! -f templater.sh ]; then
    wget https://raw.githubusercontent.com/johanhaleby/bash-templater/master/templater.sh
fi
cd datapub-gdx && npm install . && npm run build
for x in $(ls build/static/js/*.js build/static/css/*.css); do
  bundles=$bundles"\{\% resource \"${x}\" \%\}"\\n
done

cp -r build/static/* ../ckanext/datapub/fanstatic/
cd ..

export RESOURCES=$(python -c "import sys;print(sys.argv[1].replace('build/static','datapub'))" "$bundles")
bash templater.sh ckanext/datapub/templates/datapub/snippets/upload_module.template > ckanext/datapub/templates/datapub/snippets/upload_module.html
