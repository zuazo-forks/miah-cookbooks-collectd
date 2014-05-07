require 'spec_helper'

describe 'collectd::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs from package' do
    expect(chef_run).to include_recipe('collectd::_install_from_package')
  end

  it 'installs from source' do
    chef_run.node.set['collectd']['install_type'] = 'source'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('collectd::_install_from_source')
  end
end
