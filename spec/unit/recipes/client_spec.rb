require 'spec_helper'

describe 'collectd::client' do
  let(:chef_run) { ChefSpec::Runner.new(platform: 'centos', version: '6.4').converge(described_recipe) }

  it 'should install from package when install_type is package' do
    expect(chef_run).to include_recipe('collectd::_install_from_package')
  end

  it 'should install from source when install_type is source' do
    chef_run.node.set['collectd']['install_type'] = 'source'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('collectd::_install_from_source')
  end

  it 'should include _server_service' do
    expect(chef_run).to include_recipe('collectd::_server_service')
  end
end

