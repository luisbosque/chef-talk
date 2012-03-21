name "web_server"
description "Web server role"

default_run_list = ["role[base]", "recipe[nginx::default]", "recipe[web_app::default]"]
staging_run_list = ["role[base]", "recipe[nginx::sources]", "recipe[web_app::default]"]

env_run_lists(
    "_default" => default_run_list,
    "staging" => staging_run_list
)
