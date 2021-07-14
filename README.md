Enable Datapub apps in your CKAN instance.

Find out about Datapub here - https://github.com/datopian/datapub.

## Installation

Just follow standard procedure for setting up an extension for the CKAN and add `datapub` into list of the plugins. Note that this extension supports CKAN 2.8 onwards.

## Building and publishing the datapub app

To build the datapub React app we use the `sync.sh` script. This script will

1. Clone (or copy from a local folder) the datapub app source
2. Install its dependencies and create the production build
3. Update the asset references in the CKAN templates so they include the built application

The `sync.sh` accepts the following parameters:

    sync.sh [<datapub-repo-or-folder>] [<git-tag>] [<template-tag-name>]

* `<datapub-repo-or-folder>` can be a Git URL or the path to a local datapub repository. Defaults to https://github.com/datopian/datapub
* `<git-tag>` is the git tag or branch that you want to build. Defaults to `master`
* `<template-tag-name>` is used to target CKAN<=2.8 (using `resources`) or CKAN>=2.9 (using `webassets`). Defaults to `webassets`.

For example, to build a released tag of a custom datapub repo:

    ./sync.sh https://github.com/datopian/datapub v0.1.2

Same, but targetting CKAN 2.8:

    ./sync.sh https://github.com/datopian/datapub v0.1.2 resources


To build a local development clone of datapub:

    ./sync.sh ../datapub-gdx


## Template changes

This extension extends the `templates/blob_storage/snippets/upload_module.html` template:

```
{{ASSETS}}

<div id="ResourceEditor"
     data-dataset-id="{{ pkg_id }}"
     data-api="{{ base_url }}"
     data-lfs="{{ h.blob_storage_server_url() }}"
     data-auth-token="{{ api_key }}"
     data-organization-id="{{ h.blob_storage_storage_namespace() }}"
     data-resource-id="{{ resource_id }}">
</div>
```

When running `sync.sh`, the `{{ASSETS}}` placeholder will be replaced by the appropiate template tags.

On CKAN>=2.9, `{{ASSETS}}` gets replaced by these two webassets references:

```
{% asset "datapub/datapub-js" %}
{% asset "datapub/datapub-css" %}
```

On CKAN<=2.8, individual fanstatic resources need to be referenced, eg:

```
{% resource 'datapub/css/main.1eb11ae4.chunk.css' %}
{% resource 'datapub/js/runtime-main.c155da57.js' %}
{% resource 'datapub/js/2.2599189b.chunk.js' %}
{% resource 'datapub/js/main.c4752953.chunk.js' %}
```
