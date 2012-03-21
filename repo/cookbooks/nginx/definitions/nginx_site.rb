define :nginx_site, :enable => true do
  
  application_name = params[:name]

  template "#{node[:nginx][:directory]}/sites-available/#{application_name}" do
    source "nginx_site.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
      :application_name => application_name,
      :application_root => params[:application_root]
    )
    if ::File.exists?("#{node[:nginx][:directory]}/sites-enabled/#{application_name}")
      notifies :reload, resources(:service => "nginx"), :delayed
    end
  end
 
  if params[:enable]
    link "#{node[:nginx][:directory]}/sites-enabled/#{application_name}" do
      to "#{node[:nginx][:directory]}/sites-available/#{application_name}"
      notifies :reload, resources(:service => "nginx")
      not_if do
        ::File.symlink?("#{node[:nginx][:directory]}/sites-enabled/#{application_name}")
      end
    end
  else
    file "#{node[:nginx][:directory]}/sites-enabled/#{application_name}" do
      notifies :reload, resources(:service => "nginx")
      action :delete
      only_if do
        ::File.symlink?("#{node[:apache][:dir]}/sites-enabled/#{params[:name]}")
      end
    end
  end

end
