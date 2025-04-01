"""Template helpers for ckanext-datapub
"""
import ckan.plugins.toolkit as toolkit
import logging

SERVER_URL_CONF_KEY = 'ckanext.blob_storage.storage_service_url'

log = logging.getLogger(__name__)

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

def get_user_with_token(user):
    user = user.as_dict()
    context = {'ignore_auth': True}
    try:
        api_tokens = toolkit.get_action('api_token_list')(
            context, {'user_id': user['name']}
        )

        for token in api_tokens:
            if token['name'] == 'datapub_token':
                toolkit.get_action('api_token_revoke')(context, {'jti': token['id']})

        datapub_token = toolkit.get_action('api_token_create')(
            context, {'user': user['name'], 'name': 'datapub_token'}
        )

        return datapub_token.get('token')

    except Exception as e:
        log.error('Failed to generate frontend token')
        log.error(e)

