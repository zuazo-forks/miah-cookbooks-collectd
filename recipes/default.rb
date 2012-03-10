#
# Cookbook Name:: collectd
# Recipe:: default
#
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "git"
include_recipe "build-essential"
package "bison"
package "libltdl-dev"
package "libtool"
package "libgcrypt11-dev"
package "redis-server"
package "libperl-dev"
directory "/mnt/git" do
  action :create
  recursive true
  owner "root"
  group "root"
end

remote_file "/mnt/git/credis-#{node[:credis][:version]}.tar.gz" do
  source node[:credis][:release_url] 
  not_if { File.exists?("/mnt/git/credis-#{node[:credis][:version]}.tar.gz") }
end

execute "untar credis" do
  cwd "/usr/local"
  command "tar zxf /mnt/git/credis-#{node[:credis][:version]}.tar.gz"
  not_if { File.directory?("/usr/local/credis-#{node[:credis][:version]}") }
end

execute "make credis" do
  command "make all"
  cwd "/usr/local/credis-#{node[:credis][:version]}"
  not_if { File.exists?("/usr/local/credis-#{node[:credis][:version]}/libcredis.so") }
end

execute "create /usr/local/credis-#{node[:credis][:version]}/include/credis.h from /usr/local/credis-#{node[:credis][:version]}/credis.h" do
  command "mkdir -p /usr/local/credis-#{node[:credis][:version]}/include && cp /usr/local/credis-#{node[:credis][:version]}/credis.h /usr/local/credis-#{node[:credis][:version]}/include/credis.h"
  not_if { File.exists?("/usr/local/credis-#{node[:credis][:version]}/include/credis.h") }
end

execute "create /usr/local/credis-#{node[:credis][:version]}/lib/libcredis.so from /usr/local/credis-#{node[:credis][:version]}/libcredis.so" do
  command "mkdir -p /usr/local/credis-#{node[:credis][:version]}/lib && cp /usr/local/credis-#{node[:credis][:version]}/libcredis* /usr/local/credis-#{node[:credis][:version]}/lib/"
  not_if { File.exists?("/usr/local/credis-#{node[:credis][:version]}/lib/libcredis.so") } 
end

execute "create /usr/lib/libcredis*" do
  command "cp /usr/local/credis-#{node[:credis][:version]}/libcredis* /usr/lib/"
  not_if { File.exists?("/usr/lib/libcredis.so") } 
end

git "/mnt/git/collectd" do
  repository node[:collectd][:git_url]
  reference node[:collectd][:git_branch]
  action :checkout
  not_if { File.exists?("/opt/collectd/sbin/collectd") }
end

execute "build configure script" do
  not_if { File.exists?("/opt/collectd/sbin/collectd") || File.exists?("/mnt/git/collectd/configure") }
  command "./build.sh"
  cwd "/mnt/git/collectd"
end

execute "configure collectd" do
  command "./configure --prefix=#{node[:collectd][:prefix]} --sysconfdir=#{node[:collectd][:sysconfdir]} #{node[:collectd][:plugins_enabled]} #{node[:collectd][:configure_parameters]}"
  not_if { File.exists?("/opt/collectd/sbin/collectd") }
  cwd "/mnt/git/collectd"
end

execute "make collectd" do
  command "make all -j#{node[:cpu][:total]}"
  cwd "/mnt/git/collectd"
  not_if { File.exists?("/opt/collectd/sbin/collectd") }
end

execute "install collectd" do
  command "make install"
  cwd "/mnt/git/collectd"
  not_if { File.exists?("/opt/collectd/sbin/collectd") }
end

# NOTE: This file was compiled from https://github.com/Fotolia/collectd-mod-haproxy you will need to modify the Makefile with the patch below in order to produce a new binary.
#
#
#diff --git a/Makefile b/Makefile
#index 6c53460..2952dfa 100644
#--- a/Makefile
#+++ b/Makefile
##@@ -1,8 +1,8 @@ ## *Note* this line has 2 ##'s to comment it out.  It starts with @@
#-PREFIX=/usr/
#+PREFIX=/opt
# PLUGINDIR=${PREFIX}/lib/collectd
#-INCLUDEDIR=/usr/include/collectd/ 
#+INCLUDEDIR=/mnt/git/collectd/src
# 
#-CFLAGS=-I${INCLUDEDIR} -Wall -Werror -g -O2
#+CFLAGS=-I${
#
#

cookbook_file "/opt/collectd/lib/collectd/haproxy.so" do
  source "haproxy.so"
end

cookbook_file "/opt/collectd/share/collectd/haproxy.db" do
  source "haproxy.db"
end

directory node[:collectd][:sysconfdir] do
  owner "root"
  group "root"
  mode "755"
end

directory node[:collectd][:plugins_dir] do
  owner "root"
  group "root"
  mode "755"
end

directory node[:collectd][:base_dir] do
  owner "root"
  group "root"
  mode "755"
  recursive true
end

directory node[:collectd][:plugins_dir] do
  owner "root"
  group "root"
  mode "755"
  recursive true
end

directory node[:collectd][:confd_dir] do
  owner "root"
  group "root"
  mode "755"
  recursive true
end

%w(collectd collection thresholds).each do |file|
  template "#{node[:collectd][:prefix]}/etc/#{file}.conf" do
    source "#{file}.conf.erb"
    owner "root"
    group "root"
    mode "644"
    variables(
              :prefix => node[:collectd][:prefix],
              :plugindir => node[:collectd][:confd_dir]
              )
  end
end

template "#{node[:collectd][:confd_dir]}/write_graphite.conf" do
  source "write_graphite.conf.erb"
  variables(
            :host => node[:collectd][:graphite_host], 
            :port => node[:collectd][:graphite_port], 
            :prefix => node[:collectd][:graphite_prefix], 
            :postfix => node[:collectd][:graphite_postfix], 
            :storerates => node[:collectd][:graphite_storerates],
            :alwaysappendds => node[:collectd][:graphite_alwaysappendds],
            :escapecharacter => node[:collectd][:graphite_escapecharecter]
            )
end

template "#{node[:collectd][:confd_dir]}/redis.conf" do
  source "redis.conf.erb"
  variables(
            :nodename => node[:redis][:nodename],
            :hostname => node[:redis][:hostname],
            :port => node[:redis][:port],
            :timeout => node[:redis][:timeout]
            )
end


runit_service "collectd"

