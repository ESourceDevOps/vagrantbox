#
# Cookbook Name:: php-fpm
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Downloading the Webtatic repository.
remote_file "#{Chef::Config[:file_cache_path]}/webtatic_repo_latest.rpm" do
    source "https://mirror.webtatic.com/yum/el7/webtatic-release.rpm"
    action :create
end

# Installing Webtatic repository.
rpm_package "php56-rpm" do
    source "#{Chef::Config[:file_cache_path]}/webtatic_repo_latest.rpm"
    action :install
end

# Installing PHP 5.6.
package node['php-fpm']['package-list'] do
	action :install
end

# Creating the PHP configuration.
template "/etc/php.ini" do
    source "php.ini.erb"
    owner "root"
    group "root"
    mode "0644"
end

# Creating the www pool configuration.
template "/etc/php-fpm.d/www.conf" do
    source "www.conf.erb"
    owner "root"
    group "root"
    mode "0644"
end

# Starting PHP-FPM and enabling it on boot.
service 'php-fpm' do
	supports :restart => true, :reload => true
	action [ :enable, :start ]
end