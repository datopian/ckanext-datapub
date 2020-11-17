DATAPUB_APP=${1:='https://github.com/datopian/datapub'}
DATAPUB_VERSION=${2:='master'}
git clone --branch $DATAPUB_VERSION $DATAPUB_APP datapub
wget https://raw.githubusercontent.com/johanhaleby/bash-templater/master/templater.sh
cd datapub && npm install . && npm run build
for x in $(ls build/static/js/*.js build/static/css/*.css); do
  bundles=$bundles"\{\% resource \"${x}\" \%\}"\\n
done

cp -r build/static/* ../ckanext/datapub/fanstatic/
cd ..

export RESOURCES=$(python -c "import sys;print(sys.argv[1].replace('build/static','datapub'))" "$bundles")
bash templater.sh ckanext/datapub/templates/datapub/snippets/upload_module.template > ckanext/datapub/templates/datapub/snippets/upload_module.html
