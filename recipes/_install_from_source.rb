#
# Cookbook Name:: collectd
# Recipe:: _install_from_source
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

include_recipe "build-essential"
include_recipe "ark"

user_packages = %w(librrd2-dev libsnmp-dev)
unless node['collectd']['build_prereq_pkgs'].nil?
  node['collectd']['build_prereq_pkgs'].each { |pkgs| user_packages << pkgs}
end

user_packages.each do |build_pkgs|
  package build_pkgs
end

user_autoconf_options = [
  "--prefix=#{node['collectd']['prefix_dir']}",
  "--sysconfdir=#{node['collectd']['sysconf_dir']}",
  "--bindir=#{node['collectd']['bin_dir']}"
]

unless node['collectd']['autoconf_opts'].nil?
  node['collectd']['autoconf_opts'].each { |aco| user_autoconf_options << aco }
end

tar_source_url = "#{node['collectd']['source_url_prefix']}/#{node['collectd']['source_tar_name_prefix']}#{node['collectd']['version']}#{node['collectd']['source_tar_name_extension']}"

ark "collectd" do
  url tar_source_url
  version node['collectd']['version']
  checksum node['collectd']['checksum']
  path node['collectd']['prefix_dir']
  autoconf_opts user_autoconf_options
  action [ :configure, :install_with_make ]
end
