#
# Cookbook Name:: collectd
# Recipe:: client_graphite
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

include_recipe "collectd::_install_from_source"
include_recipe "collectd::_server_plugins"
include_recipe "collectd::_server_runit"
include_recipe "collectd::_server_conf"

servers = []

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
  search(:node, "roles:#{node['graphite']['server_role']} AND chef_environment:#{node.chef_environment}") do |n|
    servers << n['fqdn']
  end
end

if servers.empty?
  raise "No graphite servers found! Please configure at least one node with role: \"#{node['graphite']['server_role']}\" in environment: \"#{node.chef_environment}\"."
end

collectd_plugin "write_graphite" do
  options({ :host => servers, :storerates => false })
  type "plugin"
  source "write_graphite.conf.erb"
  cookbook "collectd"
end
