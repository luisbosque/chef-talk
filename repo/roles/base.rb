name "base"
description "Base role"
run_list(
  "recipe[git::default]",
  "recipe[munin::node]"
)
