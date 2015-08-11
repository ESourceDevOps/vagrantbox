#
# Cookbook Name:: mariadb
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

maindir = node['mysql']['maindir']
datadir = node['mysql']['datadir']

# Installing MariaDB repository.
cookbook_file "/etc/yum.repos.d/MariaDB.repo" do
  source "MariaDB.repo"
  owner "root"
  group "root"
  mode "0644"
end

# Installing MariaDB-Server.
package 'MariaDB-server' do
	action :install
end

# Installing extra packages.
package node['mysql']['extra_packages'] do
  action :install
end

# Installing python policy core utilities.
package 'policycoreutils-python' do
	action :install
end

# Creating client configuration.
template "/etc/my.cnf.d/client.cnf" do
    source "client.cnf.erb"
    owner "mysql"
    group "mysql"
    mode "0644"
end

# Creating server configuration.
template "/etc/my.cnf.d/server.cnf" do
    source "server.cnf.erb"
    owner "mysql"
    group "mysql"
    mode "0644"
end

# Creating MariaDB directories.
node['mysql']['directories'].each do |directory|
  # Creating directory.
  directory "#{directory}" do
    owner node['mysql']['user']
    group node['mysql']['group']
    mode "0775"
    action :create
    recursive true
  end
end

ruby_block 'manage-selinux-contexts' do
    block do
        # Setting SeLinux contexts.
        execute "setting-selinux-contexts" do
            command "sudo semanage fcontext -a -t mysqld_db_t \"#{maindir}(/.*)?\""
            action :run
            not_if "test -e #{datadir}/ibdata1"
            not_if "grep SELINUX=disabled /etc/selinux/config"
        end

        # Reloading SeLinux contexts.
        execute "reloading-selinux-contexts" do
            command "sudo restorecon -Rv #{maindir}"
            action :run
          not_if "test -e #{datadir}/ibdata1"
        end
    end
    not_if "grep SELINUX=disabled /etc/selinux/config"
end

# Creating ldata.
execute "creating-ldata" do
	command "sudo mysql_install_db --user=mysql --ldata=#{datadir}"
	action :run
  not_if "test -e #{datadir}/ibdata1"
end

# Starting the MySQL daemon and enabling on boot.
service "mysql" do
	supports [ :restart, :reload, :start, :stop ]
	action :enable
end