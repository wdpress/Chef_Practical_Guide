%w{mysql mysql-server}.each do |pkg|
  package pkg do
    action :install
  end
end

service "mysqld" do
  action [:enable, :start]
end

execute "set root password" do
  command "mysqladmin -u root password '#{node['mysql']['server_root_password']}'"
  only_if "mysql -u root -e 'show databases;'"
end

template "create slave user sql" do
  path "/home/#{node['mysql']['user']}/create_slave_user.sql"
  source "create_slave_user.sql.erb"
  owner node['mysql']['user']
  group node['mysql']['group']
  mode  "0644"
end

execute "exec create_slave_user.sql" do
  command "mysql -u root --password='#{node['mysql']['server_root_password']}' < /home/#{node['mysql']['user']}/create_slave_user.sql"
  user node['mysql']['user']
  group node['mysql']['group']
  environment 'HOME' => "/home/#{node['mysql']['user']}"
  only_if { node['hostname'] == "dbmaster" }
end

template "my.cnf" do
  path   "/etc/my.cnf"
  source "my.cnf.erb"
  owner  "root"
  group  "root"
  mode   "0644"
  notifies :restart, "service[mysqld]"
end
