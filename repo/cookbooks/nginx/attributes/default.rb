default['nginx']['version'] = "1.0.14"
default['nginx']['url'] = "http://nginx.org/download/nginx-#{node['nginx']['version']}.tar.gz"

default['nginx']['directory'] = "/etc/nginx"
