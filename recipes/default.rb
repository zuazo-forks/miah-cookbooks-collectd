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

# you need to build the debian packages from github.com/damm/pkg-collectd and upload them to S3 and then uncomment this with the right details for this to work
%w{libcollectdclient0_5.1.0-1_amd64.deb libcollectdclient-dev_5.1.0-1_amd64.deb collectd-core_5.1.0-1_amd64.deb collectd_5.1.0-1_amd64.deb collectd-utils_5.1.0-1_amd64.deb}.each do |remotes|
#  remote_file "/mnt/#{remotes}" do
#    source "https://s3.amazonaws.com/bucket/#{remotes}"
#    not_if { File.exists?("/mnt/#{remotes}") }
#  end
#  execute "dpkg -i /mnt/#{remotes}" do
#    not_if { File.exists?("/usr/sbin/collectd") }
#  end
#end

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

template "#{node[:collectd][:sysconfdir]}/collectd.conf" do
  source "collectd.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  variables(
            :prefix => node[:collectd][:prefix],
            :plugindir => node[:collectd][:plugins_dir]
            )
end

%w(collection thresholds).each do |file|
  template "#{node[:collectd][:confd_dir]}/#{file}.conf" do
    source "#{file}.conf.erb"
    owner "root"
    group "root"
    mode "644"
    variables(
              :prefix => node[:collectd][:prefix],
              :plugindir => node[:collectd][:plugins_dir]
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

if node.recipes.include?("memcached") 
  template "#{node[:collectd][:confd_dir]}/memcached.conf" do
    owner "root"
    group "root"
    source "memcached.conf.erb"
  end
end

service "collectd" do
  action [:start,:enable]
end
