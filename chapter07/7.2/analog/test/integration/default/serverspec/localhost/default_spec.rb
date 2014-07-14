require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/usr/sbin"
end

describe file('/usr/bin/analog') do
  it { should be_file }
  it { should be_mode 755 }
end

describe command( "/usr/bin/analog 2>/dev/null | grep 'analog 6.0'" ) do
  it { should return_exit_status 0 }
end

describe package('analog') do
  it { should be_installed }
end
