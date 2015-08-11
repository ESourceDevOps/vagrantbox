#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

nginx_user = node['nginx']['user']
nginx_group = node['nginx']['group']
time = Time.new
datestamp = "#{time.year}#{time.month}#{time.day}_#{time.hour}_#{time.min}_#{time.sec}"

# Installing epel-release.
package 'epel-release' do
    action :install
end

# Installing Nginx.
package 'nginx' do
    action :install
end

# Creating the webroot.
directory node['nginx']['root'] do
    user nginx_user
    group nginx_group
    mode "0775"
    action :create
    recursive true
end

# Creating the logging directory.
directory node['nginx']['logdir'] do
    user nginx_user
    group nginx_group
    mode "0775"
    action :create
    recursive true
end

# Backing up the nginx directory.
execute 'back-up-nginx-directory' do
    command "sudo mv /etc/nginx /etc/nginx.bak.#{datestamp}"
end

# Creating the nginx directory.
directory '/etc/nginx' do
    action :create
    user 'root'
    group 'root'
    mode '0755'
    action :create
    recursive true
end

# Creating the configuration directories.
node['nginx']['conf_directories'].each do |path|
    # Determine if the attributes path has provided a leading forward slash.
    full_path = '/etc/nginx' + ((path[0, 1] == '/') ? '' : '/') + path
    
    # Creating the config directory.
    directory "#{full_path}" do
        action :create
        user 'root'
        group 'root'
        mode '0755'
        action :create
        recursive true
    end 
end

# Creating the app config files.
node['nginx']['conf_templates'].each do |file|
    # Determine if the attributes path has provided a leading forward slash.
    path = file['path']
    name = file['name']
    full_path = '/etc/nginx' + ((path[0, 1] == '/') ? '' : '/') + path + ((path[-1, 1] == '/') ? '' : '/') + name
    
    template "#{full_path}" do
        source "#{name}.erb"
        owner 'root'
        group 'root'
        mode '0644'
    end
end

# Creating the nginx configuration files.
node['nginx']['conf_files'].each do |file|
    cookbook_file "/etc/nginx#{file['path']}#{file['name']}" do
        source "#{file['name']}"
        owner 'root'
        group 'root'
        mode '0644'
    end
end

# Creating link to default.conf.
link '/etc/nginx/sites-enabled/default.conf' do
    to '/etc/nginx/sites-available/default.conf'
    group nginx_group
    user nginx_user
    mode '0644'
end

# Creating the security certificate.
cookbook_file '/etc/nginx/server.crt' do
    source 'server.crt'
    owner 'root'
    group 'root'
    mode '0644'
end

# Creating the security certificate key.
cookbook_file '/etc/nginx/server.key' do
    source 'server.key'
    owner 'root'
    group 'root'
    mode '0644'
end

# Creating the microcache directory.
directory '/var/cache/nginx/microcache' do
    user nginx_user
    group nginx_group
    mode '0755'
    recursive true
end