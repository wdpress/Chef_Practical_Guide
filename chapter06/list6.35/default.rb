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
