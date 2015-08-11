#
# Cookbook Name:: ntp
# Recipe:: default
#
# Copyright 2015, E Source Companies, LLC
#

# Installing ntp.
package 'ntp' do
	action :install
end

# Starting ntp and enabling it on boot.
service 'ntpd' do
    supports [ :start, :stop, :status, :restart, :reload ]
    action [ :enable, :start ]
end