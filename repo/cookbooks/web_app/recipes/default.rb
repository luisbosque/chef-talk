#
# Cookbook Name:: web_app
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory node['web_app']['path'] do
  owner "www-data"
  group "www-data"
  mode 0755
  recursive true
end

git node['web_app']['path'] do
  repository "git://github.com/lbosque/hello_devops.git"
  user "www-data"
  group "www-data"
  action :export
end

nginx_site "web.net.local" do
  application_root node['web_app']['path']
end
