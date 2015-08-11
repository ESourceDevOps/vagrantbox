##
# Cookbook Name:: php-fpm
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

default['php-fpm']['package-list'] = [
	'php56w',
	'php56w-cli',
	'php56w-common',
    'php56w-cgi',
	'php56w-fpm',
	'php56w-gd',
	'php56w-mbstring',
	'php56w-mcrypt',
	'php56w-mysql',
	'php56w-opcache',
	'php56w-pdo',
	'php56w-pear',
	'php56w-pecl-imagick',
	'php56w-pecl-memcache',
	'php56w-tidy',
	'php56w-xml',
	'php56w-xmlrpc'
]

default['php-fpm']['unix-socket'] = '/var/run/php-fpm.sock'
default['php-fpm']['listen-owner'] = 'nginx'
default['php-fpm']['listen-group'] = 'nginx'
default['php-fpm']['user'] = 'nginx'
default['php-fpm']['group'] = 'nginx'