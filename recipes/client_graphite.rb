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
  if node['graphite']['server_address']
    servers << node['graphite']['server_address']
  else
    servers << '127.0.0.1'
  end
else
  search(:node, "role:#{node['graphite']['server_role']} AND chef_environment:#{node.chef_environment}") do |n|
    servers << n['fqdn']
  end
end

collectd_plugin "write_graphite" do
  options({ :host => servers, :storerates => false })
  type "plugin"
  source "write_graphite.conf.erb"
  cookbook "collectd"
end
