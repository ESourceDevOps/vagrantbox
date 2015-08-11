#
# Cookbook Name:: memcached
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Installing memcached.
package "memcached" do
	action :install
end

# Starting and enabling memcached on boot.
service "memcached" do
	supports [ :start, :stop, :restart, :reload ]
	action [ :enable, :start ]
end