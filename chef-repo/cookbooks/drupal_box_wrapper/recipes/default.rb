#
# Cookbook Name:: php_fpm_box_wrapper
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Disabling SeLinux.
bash 'disabling-selinux' do
	user 'root'
	code <<-EOH
		setenforce 0
		sed -i -e 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
	EOH
    not_if 'grep SELINUX=disabled /etc/selinux/config'
end

# Including the cookbooks necessary for the various parts of the stack.
begin
    include_recipe 'mariadb::default'
    include_recipe 'nginx::default'
	include_recipe 'php-fpm::default'
    include_recipe 'firewalld::default'
	include_recipe 'memcached::default'
    include_recipe 'varnish::default'
    include_recipe 'solr::default'
    include_recipe 'ntp::default'
	
    rescue Chef::Exceptions::RecipeNotFound
        Chef::Log.warn <<-EOH
            The Cookbook was not found.
		EOH
end

# Creating the devdes group.
group 'devdes' do
    action :create
    not_if 'getent group devdes', :user => 'root'
end

# Adding current user to the devdes group.
group 'devdes' do
    members 'vagrant'
    action :modify
    append true
end

# Setting permissions on the base directory.
directory node['drupal_box_wrapper']['basedir'] do
    group 'devdes'
    user 'root'
    mode '0775'
    action :create
    only_if 'getent group devdes'
end

# Installing standard packages.
package node['drupal_box_wrapper']['standard_packages'] do
  action :install
end

# Installing Drush.
bash 'installing-drush' do
	user 'root'
	code <<-EOH
		pear channel-discover pear.drush.org
        pear install drush/drush
		drush
	EOH
    not_if { File.exists?('/usr/bin/drush') }
end

# Starting mysql and enabling it on boot.
service 'mysql' do
    supports [ :enable, :start, :stop, :reload, :status, :restart ]
	action [ :enable, :restart ]
end

# Starting php-fpm and enabling it on boot.
service 'php-fpm' do
  supports [ :enable, :start, :stop, :reload, :status, :restart ]
  action [ :enable, :restart ]
end

# Starting nginx and enabling it on boot.
service 'nginx' do
  supports [ :enable, :start, :stop, :reload, :status, :restart ]
  action [ :enable, :restart ]
end

# Starting nginx and enabling it on boot.
service 'solr' do
  supports [ :enable, :start, :stop, :status, :restart ]
  action [ :enable, :restart ]
end

# Create the lockfile and notifying the secure install command.
file '/esource/mysql/lockfile' do
    action :create_if_missing
    notifies :run, 'bash[mysql-secure-installation]', :immediately
end

# Securing the mysql installation.
bash 'mysql-secure-installation' do
	user 'root'
	code <<-EOH
        mysql -e "UPDATE mysql.user SET Password = PASSWORD('password') WHERE User = 'root'"
        mysql -e "DROP USER ''@'localhost'"
        mysql -e "DROP USER ''@'$(hostname)'"
        mysql -e "DROP DATABASE test"
        mysql -e "FLUSH PRIVILEGES"
	EOH
    action :nothing
end

# Creating the users .my.cnf file.
cookbook_file '/home/vagrant/.my.cnf' do
    source '.my.cnf'
    owner 'vagrant'
    group 'vagrant'
    mode '0664'
    not_if { File.exists?('/home/vagrant/.my.cnf') }
end

# Creating the sysctl configuration with high concurrency web server kernel tweaks.
cookbook_file '/etc/sysctl.conf' do
    source 'sysctl.conf'
    owner 'root'
    group 'root'
    mode '0644'
end