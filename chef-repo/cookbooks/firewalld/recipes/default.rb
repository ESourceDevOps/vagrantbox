#
# Cookbook Name:: firewalld
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Installing firewalld.
package "firewalld" do
  action :install
  not_if { File.exists?("/etc/init.d/firewalld") }
end

# Starting firewalld and enabling it on boot.
service "firewalld" do
  supports [ :enable, :start, :stop, :restart, :reload, :status ]
  action [ :enable, :start ]
end

# Adding the internal services to firewalld rules.
node['firewalld']['internal']['services'].each do |service|
  execute "firewall-setup-service-#{service}" do
    command "firewall-cmd --permanent --zone=internal --add-service=#{service}"
  end
end

# Adding the internal ports to firewalld rules.
node['firewalld']['internal']['ports'].each do |port|
  execute "firewall-setup-port-#{port}" do
    command "firewall-cmd --permanent --zone=internal --add-port=#{port}/tcp"
  end
end

# Adding the public services to firewalld rules.
node['firewalld']['public']['services'].each do |service|
  execute "firewall-setup-service-#{service}" do
    command "firewall-cmd --permanent --zone=public --add-service=#{service}"
  end
end

# Adding the public ports to firewalld rules.
node['firewalld']['public']['ports'].each do |port|
  execute "firewall-setup-port-#{port}" do
    command "firewall-cmd --permanent --zone=public --add-port=#{port}/tcp"
  end
end

# Restarting the firewall and enabling on boot.
service "firewalld" do
  supports [ :status, :restart, :reload, :start, :stop ]
  action [ :enable, :restart ]
end