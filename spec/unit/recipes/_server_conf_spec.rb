require 'spec_helper'

describe 'collectd::_server_conf' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  let(:collectd) { chef_run.node['collectd'] }

  it 'should create directories with permissions' do
    [collectd['sysconf_dir'], collectd['plugconf_dir']].each do |dir|
      expect(chef_run).to create_directory(dir).with(
        user: 'root',
        group: 'root',
        mode: '0755'
      )
    end
  end

  it 'should create templates with permissions' do
    %w(collectd thresholds).each do |file|
      expect(chef_run).to create_template("#{collectd['sysconf_dir']}/#{file}.conf").with(
        user: 'root',
        group: 'root',
        mode: '0644',
      )
    end
  end
end
