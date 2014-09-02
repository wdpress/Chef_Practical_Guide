#
# Cookbook Name:: analog
# Recipe:: default 
#
# Author:: Ryuzee <ryuzee@gmail.com>
#
# Copyright 2013, Ryutaro YOSHIBA 
#
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

case node[:platform]
when "centos"
  platform_version = node[:platform_version].to_f

  if platform_version >= 6.0 then
    rpmfile = "analog-6.0.4-1.x86_64.rpm"
  elsif platform_version >= 5.0 then
    rpmfile = "analog-6.0.4-1.el5.i386.rpm"
  else
    raise "This recipe can not be applied to this environment!!"
  end

  remote_file "#{Chef::Config[:file_cache_path]}/#{rpmfile}" do
    source "http://www.iddl.vt.edu/~jackie/analog/#{rpmfile}"
  end

  package 'perl' do
    action :install
  end

  package "analog" do
    action :install
    source "#{Chef::Config[:file_cache_path]}/#{rpmfile}"
    provider Chef::Provider::Package::Rpm
  end
end

# vim: filetype=ruby.chef
