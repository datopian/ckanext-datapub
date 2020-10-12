"""Template helpers for ckanext-datapub
"""
import ckan.plugins.toolkit as toolkit

SERVER_URL_CONF_KEY = 'ckanext.external_storage.storage_service_url'


def lfs_url():
    return toolkit.config.get(SERVER_URL_CONF_KEY)


def organization_name(package_name=None):
    if package_name:
        context = {'ignore_auth': True}
        try:
            data_dict = {'id': package_name}
            package = toolkit.get_action('package_show')(context, data_dict)
        except toolkit.ObjectNotFound:
            return ''

        org = package.get('organization')
        if not org and package.get('owner_org'):
            org = toolkit.get_action('organization_show')(context, {'id': package['owner_org']})

        if org:
            return org.get('name')
        else:
            return '_'
    else:
        return '_'
