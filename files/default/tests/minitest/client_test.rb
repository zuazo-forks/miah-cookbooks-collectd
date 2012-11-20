require File.expand_path('../support/helpers', __FILE__)

describe 'collectd::client' do
  include Helpers::Collectd

  it 'installs collectd' do
    package('collectd').must_be_installed
  end

  it 'starts collectd' do
    service('collectd').must_be_running
  end

  it 'enables collectd' do
    service('collectd').must_be_enabled
  end

  describe 'configuration' do
    it { collectd_config_parses? }
  end

end
