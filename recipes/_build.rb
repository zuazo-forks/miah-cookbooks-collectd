# Cookbook Name:: collectd
# Recipe:: _build
# build and install collectd and use alternave values for
# prefix_root, prefix_home, and prefix_bin

%w(librrd2-dev libsensors-dev libsnmp-dev).each do |req|
	resource req
end

tar_source_url = "#{node['collectd']['source_url_prefix']}#{node['collectd']['source_url_prefix']}#{node['collectd']['version']}#{default['collectd']['source_tar_name_extension']}"

 ark "collectd" do
   url tar_source_url
   version node['collectd']['version']
   checksum node['collectd']['checksum']
   prefix_root node['collectd']['prefix_root']
   prefix_home node['collectd']['prefix_home']
   prefix_bin  node['collectd']['prefix_bin']
   action :install_with_make
 end    