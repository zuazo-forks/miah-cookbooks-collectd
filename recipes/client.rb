#
# Cookbook Name:: collectd
# Recipe:: client
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

case node['collectd']['install_type']
when 'source'
  include_recipe "collectd::_install_from_source"
when 'package'
  include_recipe "collectd::_install_from_package"
end

include_recipe "collectd::_server_conf"

case node.platform_family
when 'rhel', 'fedora'
  include_recipe "collectd::_server_service"
when 'debian', 'ubuntu'
  include_recipe "collectd::_server_runit"
end

servers = []

if Chef::Config[:solo]
  Chef::Log.warn("This recipe uses search. Chef Solo does not support search.")
else
	search(:node, "role:#{node['collectd']['server_role']} AND #{node.chef_environment}") do |n|
  		servers << n['fqdn']
	end
end

if servers.empty?
  raise "No collectd servers found! Please configure at least one node with role: \"#{node['collectd']['server_role']}\" in environment: \"#{node.chef_environment}\"."
end

collectd_plugin "network" do
  options :server=>servers
end
