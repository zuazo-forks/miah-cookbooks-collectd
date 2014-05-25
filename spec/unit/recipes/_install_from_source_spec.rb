require 'spec_helper'

describe 'collectd::_install_from_source' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:collectd) { chef_run.node['collectd'] }

  it 'should include build-essential' do
    expect(chef_run).to include_recipe('build-essential')
  end

  it 'should include ark' do
    expect(chef_run).to include_recipe('ark')
  end

  it 'should install build pre req packages' do
    collectd['build_prereq_pkgs'].each do |pkg|
      expect(chef_run).to install_package(pkg)
    end
  end
end
