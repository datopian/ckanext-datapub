git clone git@github.com:datopian/datapub.git
cd datapub
yarn
yarn build
cd -
rm -r ckanext/datapub/fanstatic/**/*
cp datapub/build/static/* ckanext/datapub/fanstatic/
