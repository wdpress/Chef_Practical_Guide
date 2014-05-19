include_recipe "yum-epel"

package "nginx" do
  action :install
end

service "nginx" do
  action [ :enable, :start ]
  supports :status => true, :restart => true, :reload => true
end

template 'nginx.conf' do
  path '/etc/nginx/nginx.conf'
  source "nginx.conf.erb"
  owner 'root'
  group 'root'
  mode '0644'
  notifies :reload, "service[nginx]"
end
