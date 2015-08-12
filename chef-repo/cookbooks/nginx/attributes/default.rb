#
# Cookbook Name:: nginx
# Attributes:: default
#
# Copyright 2015, E Source Companies, LLC
#

default['nginx']['user'] = 'nginx'
default['nginx']['http_redirect_listen_port'] = '80'
default['nginx']['listen_port'] = '6085'
default['nginx']['varnish_port'] = '6085'
default['nginx']['listen_ssl'] = '443'
default['nginx']['server_name'] = 'local.drupalbox.com' # <-- Do not include the http or www parts.
default['nginx']['root'] = '/esource/html'
default['nginx']['default_documents'] = 'index.php index.html index.htm'
default['nginx']['fcgi_socket_path'] = '/var/run/php-fpm/php-fpm.sock'
default['nginx']['logdir'] = '/esource/logs'
default['nginx']['log_format'] = 'combined'
default['nginx']['arbeit'] = '500'
default['nginx']['access_log'] = 'nginx-access.log'
default['nginx']['error_log'] = 'nginx-error.log'
default['nginx']['conf_directories'] = [
    'apps/drupal',
    'sites-available',
    'sites-enabled',
]
default['nginx']['conf_templates'] = [
    { 'path' => 'apps/drupal', 'name' => 'admin_basic_auth.conf' },
    { 'path' => 'apps/drupal', 'name' => 'cron_allowed_hosts.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_boost.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_boost_escaped.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_cron_update.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_escaped.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_install.conf' },
    { 'path' => 'apps/drupal', 'name' => 'drupal_upload_progress.conf' },
    { 'path' => 'apps/drupal', 'name' => 'fastcgi_drupal.conf' },
    { 'path' => 'apps/drupal', 'name' => 'fastcgi_no_args_drupal.conf' },
    { 'path' => 'apps/drupal', 'name' => 'hotlinking_protection.conf' },
    { 'path' => 'apps/drupal', 'name' => 'map_cache.conf' },
    { 'path' => 'apps/drupal', 'name' => 'microcache_fcgi.conf' },
    { 'path' => 'apps/drupal', 'name' => 'microcache_fcgi_auth.conf' },
    { 'path' => 'apps/drupal', 'name' => 'microcache_proxy.conf' },
    { 'path' => 'apps/drupal', 'name' => 'microcache_proxy_auth.conf' },
    { 'path' => 'sites-available', 'name' => 'default.conf' },
    { 'path' => '/', 'name' => '.htpasswd-users' },
    { 'path' => '/', 'name' => 'blacklist.conf' },
    { 'path' => '/', 'name' => 'fastcgi.conf' },
    { 'path' => '/', 'name' => 'fastcgi_microcache_zone.conf' },
    { 'path' => '/', 'name' => 'fastcgi_params' },
    { 'path' => '/', 'name' => 'map_block_http_methods.conf' },
    { 'path' => '/', 'name' => 'map_https_fcgi.conf' },
    { 'path' => '/', 'name' => 'nginx.conf' },
    { 'path' => '/', 'name' => 'nginx_status_allowed_hosts.conf' },
    { 'path' => '/', 'name' => 'nginx_status_vhost.conf' },
    { 'path' => '/', 'name' => 'php_fpm_status_allowed_hosts.conf' },
    { 'path' => '/', 'name' => 'nginx_status_vhost.conf' },
    { 'path' => '/', 'name' => 'php_fpm_status_allowed_hosts.conf' },
    { 'path' => '/', 'name' => 'php_fpm_status_vhost.conf' },
    { 'path' => '/', 'name' => 'proxy_microcache_zone.conf' },
    { 'path' => '/', 'name' => 'reverse_proxy.conf' },
    { 'path' => '/', 'name' => 'upstream_phpapache.conf' },
    { 'path' => '/', 'name' => 'upstream_phpcgi_tcp.conf' },
    { 'path' => '/', 'name' => 'upstream_phpcgi_unix.conf' },
]
default['nginx']['conf_files'] = [
    { 'path' => 'sites-available', 'name' => '000-default' },
    { 'path' => '/', 'name' => 'dh_param.pem' },
    { 'path' => '/', 'name' => 'koi-utf' },
    { 'path' => '/', 'name' => 'koi-win' },
    { 'path' => '/', 'name' => 'mime.types' },
    { 'path' => '/', 'name' => 'win-utf' }
]
