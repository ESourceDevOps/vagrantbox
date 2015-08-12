#
# Cookbook Name:: drupal_box_wrapper
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Defines the main directory for the server. Where nginx, maria, etc lives.
# Typically a folder mounted to a secondary device.
default['drupal_box_wrapper']['basedir'] = '/esource'

# The standard packages that are to be installed on the server.
default['drupal_box_wrapper']['standard_packages'] = [
    'git',
    'nano',
    'tree',
    'epel-release',
    'vim',
]

# Override the server name if necessary.
default['nginx']['server_name'] = 'local.drupalbox.com' # <-- Do not include the http or www parts.