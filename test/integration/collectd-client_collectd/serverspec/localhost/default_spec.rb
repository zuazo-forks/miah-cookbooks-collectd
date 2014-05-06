
require 'spec_helper'

describe file('/etc/collectd/plugins/network.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin network

<Plugin network>
  Server "127.0.0.1"
</Plugin>'}
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end
