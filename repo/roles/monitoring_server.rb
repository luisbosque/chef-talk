name "monitoring_server"
description "Monitor server role"

run_list(
  "role[base]",
  "recipe[nginx::default]",
  "recipe[munin::server]"
)
