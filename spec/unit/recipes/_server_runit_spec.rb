require 'spec_helper'

describe 'collectd::_server_runit' do
  let(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe) }

  it 'should include the runit recipe' do
    expect(chef_run).to include_recipe('runit')
  end

  it 'should setup the runit service' do
    pending('new runit release')
    #expect(chef_run).to start_runit('collectd')
  end
end
