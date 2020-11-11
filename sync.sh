DATAPUB_APP=${1:='https://github.com/datopian/datapub'}
git clone $DATAPUB_APP datapub
cd datapub && npm install . && npm run build
wget https://raw.githubusercontent.com/johanhaleby/bash-templater/master/templater.sh
for x in $(ls build/static/js/*.js build/static/css/*.css); do
  bundles=$bundles"\{\% resource '$x' \%\}"\\n
done

cp -r build/static/* datapub/fanstatic/
export RESOURCES=$(python -c "import sys;print(sys.argv[1].replace('build/static','datapub/fanstatic'))" "$bundles")
bash templater.sh ../ckanext/datapub/templates/datapub/snippets/upload_module.template > ../ckanext/datapub/templates/datapub/snippets/upload_module.html
