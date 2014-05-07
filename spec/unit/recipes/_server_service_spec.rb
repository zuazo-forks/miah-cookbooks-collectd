require 'spec_helper'

describe 'collectd::_server_service' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:collectd) { chef_run.node['collectd'] }

  it 'should render the init template' do
    expect(chef_run).to create_template('/etc/init.d/collectd').with(
      user: 'root',
      group: 'root',
      mode: '0755',
    )
  end

  it 'should enable and start the collectd server' do
    expect(chef_run).to enable_service('collectd')
    expect(chef_run).to start_service('collectd')
  end
end
