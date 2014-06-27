package "mysql-server" do
  action :install
end

service "mysqld" do
  action [ :enable, :start ]
end
