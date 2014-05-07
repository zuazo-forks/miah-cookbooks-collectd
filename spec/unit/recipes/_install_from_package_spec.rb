require 'spec_helper'

describe 'collectd::_install_from_package' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'should include apt on debian' do
    chef_run.node.set['platform_family'] = 'debian'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('apt')
  end

  it 'should include yum-epel on rhel' do
    chef_run.node.set['platform_family'] = 'rhel'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('yum-epel')
  end

  it 'runs a execute kill collectdmon' do
    expect(chef_run).to_not run_execute('kill_collectdmon')
  end

  it 'installs the collectd package' do
    expect(chef_run).to install_package('collectd')
  end
end
