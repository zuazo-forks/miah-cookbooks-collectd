require 'spec_helper'

describe 'collectd::server' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include recipe client' do
    expect(chef_run).to include_recipe('collectd::client')
  end

  it 'should include recipe _server_logfile' do
    expect(chef_run).to include_recipe('collectd::_server_logfile')
  end

  it 'should use collectd_plugin to setup network' do
    expect(chef_run).to create_collectd_plugin('network')
  end
end
