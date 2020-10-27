git clone git@github.com:datopian/datapub-nhs.git
cd datapub-nhs
yarn
yarn build
cd -
rm -r ckanext/datapub/fanstatic/**/*
cp -r datapub-nhs/build/static/* ckanext/datapub/fanstatic/
