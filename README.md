Enable Datapub apps in your CKAN instance.

Find out about Datapub here - https://github.com/datopian/datapub.

## Installation

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
