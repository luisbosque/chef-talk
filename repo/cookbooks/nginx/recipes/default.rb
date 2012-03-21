#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "nginx"

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
end
