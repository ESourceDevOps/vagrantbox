#
# Cookbook Name:: drupal_box_wrapper
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Defines the main directory for the server. Where nginx, maria, etc lives.
# Typically a folder mounted to a secondary device.
default['drupal_box_wrapper']['basedir'] = '/esource'


# Change this to local or remote to have the provisioner create the devdes
# group and put vagrant in it.
default['drupal_box_wrapper']['box_type'] = 'local'

# The standard packages that are to be installed on the server.
default['drupal_box_wrapper']['standard_packages'] = [
    'git',
    'nano',
    'tree',
    'epel-release',
    'vim',
]

# Override the nginx ports to work with Varnish.
default['nginx']['listen_port'] = '6082'
default['nginx']['listen_port_ssl'] = '6082'