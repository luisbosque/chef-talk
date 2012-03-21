#
# Cookbook Name:: nginx
# Recipe:: sources
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "libpcre3-dev"
package "zlib1g-dev"

remote_file "/usr/local/src/nginx-#{node['nginx']['version']}.tar.gz" do
  source node['nginx']['url']
  action :create_if_missing
end

bash "compile_nginx" do
  code <<-EOH
cd /usr/local/src
tar xzf /usr/local/src/nginx-#{node['nginx']['version']}.tar.gz
cd nginx-#{node['nginx']['version']}
./configure
make
make install
  EOH
  not_if { File.exists?("/usr/local/nginx/sbin/nginx") }
end

link node['nginx']['directory'] do
  to "/usr/local/nginx/conf"
end

directory "/var/log/nginx" do
  owner "root"
  group "root"
  mode 0755
end

directory "#{node['nginx']['directory']}/sites-enabled" do
  owner "root"
  group "root"
  mode 0755
end

directory "#{node['nginx']['directory']}/sites-available" do
  owner "root"
  group "root"
  mode 0755
end

template "#{node['nginx']['directory']}/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "/etc/init.d/nginx" do
  source "nginx_init.erb"
  owner "root"
  group "root"
  mode 0750
end

service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [ :start ]
  subscribes :reload, resources(:template => ["/etc/nginx/nginx.conf", "/etc/init.d/nginx"])
end
