#
# Cookbook Name:: munin
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "munin-node"

service "munin-node" do
  supports :restart => true
  action :enable
end

template "/etc/munin/munin-node.conf" do
  source "munin-node.conf.erb"
  mode 0644
  variables(
    :munin_servers => search(:node, "role:#{node['munin']['server_role']}")
  )
  notifies :restart, resources(:service => "munin-node")
end
