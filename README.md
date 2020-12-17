Enable Datapub apps in your CKAN instance.

Find out about Datapub here - https://github.com/datopian/datapub.

## Installation

This extension requires https://github.com/datopian/ckanext-blob-storage to be enabled as it uses `storage_service_url` for uploading files.

Just follow standard procedure for setting up an extension for the CKAN and add `datapub` into list of the plugins. Note that this extension was developed and tested using version 2.8.

Setup JS modules:

```
DATAPUB_VERSION=v0.0.39; ./sync.sh
```

It would:

* git clone or update the datapub repo (can be any custom repo, by default, it is https://github.com/datopian/datapub-gdx)
* install dependencies
* build
* update JS modules in fanstatic

**Note:**

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
