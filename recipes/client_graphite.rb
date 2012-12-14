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

include_recipe "collectd::client"

if !Chef::Config[:solo] && !node['graphite']['server_role'].nil?
  search(:node, "role:#{node['graphite']['server_role']} AND chef_environment:#{node.chef_environment}") do |n|
    server = n['fqdn']
  end
end

server = node['graphite']['server_address'] || "127.0.0.1" if server.nil?

collectd_plugin 'write_graphite' do
  template "write_graphite.conf.erb"
  options({
    :host => server,
    :port => 2003,
    :prefix => node['collectd']['graphite_prefix'],
    :escape_character => "_",
    :store_rates => false
  })
end
