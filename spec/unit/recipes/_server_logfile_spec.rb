require 'spec_helper'

describe 'collectd::_server_logfile' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:collectd) { chef_run.node['collectd'] }

  it 'should include recipe logrotate' do
    expect(chef_run).to include_recipe('collectd::_server_logrotate')
  end

  it 'should create directories with permissions' do
    expect(chef_run).to create_directory(collectd['log_dir']).with(
      user: 'root',
      group: 'root',
      mode: 0755
    )
  end

  it 'should use collectd_plugin to setup logfile' do
    expect(chef_run).to create_collectd_plugin('logfile')
  end
end
