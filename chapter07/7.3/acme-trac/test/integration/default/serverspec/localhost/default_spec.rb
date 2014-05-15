require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/user/sbin"
end

%w{httpd subversion}.each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

describe service('httpd') do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

%w{subversion.conf subversion_sandbox.conf trac_sandbox.conf wsgi.conf}.each do |filename|
  describe file("/etc/httpd/conf.d/#{filename}") do
    it { should be_file }
    it { should be_readable.by_user('root') }
  end
end

describe file("/opt/trac/sandbox") do
  it { should be_owned_by 'apache' }
end

describe file("/opt/svn/sandbox") do
  it { should be_owned_by 'apache' }
end

describe file("/opt/trac_svn_password") do
  it { should be_owned_by 'apache' }
  it { should contain "admin" }
  it { should be_writable.by_user('apache') }
end

describe command("wget -q http://localhost/sandbox -O - | head -100 | grep trac") do
  it { should return_stdout /trac/ }
end
