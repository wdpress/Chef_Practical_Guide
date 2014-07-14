# vim: ft=ruby

describe 'analog' do
  require 'chef/mixin/shell_out'
  include Chef::Mixin::ShellOut
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it 'installs analog' do
    # minitest-chef-handler
    package('analog').must_be_installed
    file('/usr/bin/analog').must_exist

    # minitest
    assert File.exist?('/usr/bin/analog')
  end

  it 'has correct permission' do
    file('/usr/bin/analog').must_have(:mode, "0755")
  end

  it 'is version6' do
    info = shell_out "analog -v"
    info.stdout.must_match(/analog 6/) #this is a regex match
  end
end
