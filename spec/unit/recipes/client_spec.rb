require 'spec_helper'

describe 'collectd::client' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:chef_source) { ChefSpec::Runner.new(platform: 'debian', version: '7.0') }

  it 'should install from package when install_type is package' do
    expect(chef_run).to include_recipe('collectd::_install_from_package')
  end

  it 'should install from source when install_type is source' do
    chef_source.node.set['collectd']['install_type'] = 'source'
    chef_source.converge(described_recipe)
    expect(chef_source).to include_recipe('collectd::_install_from_source')
  end

  it 'should include _server_service' do
    expect(chef_run).to include_recipe('collectd::_server_service')
  end
end

