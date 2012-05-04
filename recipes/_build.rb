# Cookbook Name:: collectd
# Recipe:: _build

include_recipe "build-essential"
# ** HOW do we handle these dependencies? --> apt-get install librrd2-dev libsensors-dev libsnmp-dev

src_dir = node['collectd']['source_directory']
dst_dir = node['collectd']['base_dir']

%w[ src_dir dst_dir ].each do |dir|
  directory node['collectd'][dir] do
  
  # ** No user /group defined for collectd
    owner node['collectd']['user']
    group node['collectd']['group']
    action :create
  end
end

execute "install-collectd" do
  cwd node['collectd']['source_directory']
  # ** IS this right? default install dir for collectd is /opt/collectd/
  command "make PREFIX=#{node['collectd']['base_dir']} install"
  #not actually sure what this 'creates'
  creates "#{node['collectd']['base_dir']}/bin/redis-server"
  # ** no collectd user -- > user node['collectd']['user']
  action :nothing
end

execute "make-collectd" do
  cwd node['collectd']['source_directory']
  command "make"
  creates "collectd"
  # ** no collectd user -- > user node['collectd']['user']
  action :nothing
  notifies :run, "execute[install-collectd]", :immediately
end

execute "collectd-extract-source" do
	# ** Double check flags on the un-tar
  command "tar zxf #{Chef::Config['file_cache_path']}/#{node['collectd']['tarball']} --strip-components 1 -C #{node['collectd']['source_directory']}"
  creates "#{node['collectd']['source_directory']}/COPYING"
  only_if do File.exist?("#{Chef::Config['file_cache_path']}/#{node['collectd']['tarball']}") end
  action :run
  notifies :run, "execute[make-collectd]", :immediately
end

remote_file "#{Chef::Config['file_cache_path']}/#{node['collectd']['tarball']}" do
  source node['collectd']['source_url']
  mode 0644
  # ** Need to locate and define a checksum
  #checksum node['collectd']['source']['sha']
  notifies :run, "execute[collectd-extract-source]", :immediately
end
