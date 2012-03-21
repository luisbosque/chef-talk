#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin"

directory "/var/www/munin" do
  owner "munin"
  group "munin"
  mode 0755
end

munin_nodes = search(:node, "munin:[* TO *]")

template "/etc/munin/munin.conf" do
  source "munin.conf.erb"
  mode 0644
  variables(:munin_nodes => munin_nodes)
end

nginx_site "munin.net.local" do
  application_root "/var/www/munin"
end
