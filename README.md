Enable Datapub apps in your CKAN instance.

Find out about Datapub here - https://github.com/datopian/datapub.

## Installation

This extension requires https://github.com/datopian/ckanext-blob-storage to be enabled as it uses `storage_service_url` for uploading files.

Just follow standard procedure for setting up an extension for the CKAN and add `datapub` into list of the plugins. Note that this extension was developed and tested using version 2.8.

Setup JS modules:

```
sh sync.sh
```

It would:

* git clone the datapub repo (can be any custom repo, by default, it is https://github.com/datopian/datapub)
* install dependencies
* build
* update JS modules in fanstatic

Next, you need to update the template to include correct bundles. In `/templates/datapub/snippets/upload_module.html`, edit the file names of the modules.

**Note:**

- If you are importing a component from the datapub library, when running `yarn build` will generate two CSS files. Both of these CSS files should be added In `/templates/datapub/snippets/upload_module.html` be able to render external components imported.

e.g.
```
{% resource 'datapub/css/2.13e0d705.chunk.css' %}
{% resource 'datapub/css/main.c6297111.chunk.css' %}
{% resource 'datapub/js/runtime-main.95a62798.js' %}
{% resource 'datapub/js/2.bfcaf294.chunk.js' %}
{% resource 'datapub/js/main.d1dbf6f8.chunk.js' %}
```

- if you are developing a React app, e.g., custom `datapub` app, you can use the following attributes passed from the `/templates/datapub/snippets/upload_module.html`:

```html
<div id="ResourceEditor"
     data-dataset-id="{{ pkg_name }}"
     data-api="{{ base_url }}"
     data-lfs="{{ h.extstorage_lfs_url() }}"
     data-auth-token="{{ api_key }}"
     data-organization-id="{{ h.extstorage_organization_name(pkg_name) }}"
     data-resource-id="{{ resource_id }}">
</div>
```
