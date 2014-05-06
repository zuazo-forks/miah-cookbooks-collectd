
require 'spec_helper'

describe file('/etc/collectd/plugins/network.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin network

<Plugin network>
  Listen "0.0.0.0"
</Plugin>'}
end

describe file('/etc/collectd/plugins/logfile.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin logfile

<Plugin logfile>
  Loglevel "error"
  File "/var/log/collectd//collectd.log"
  Timestamp "true"
  Printseverity "false"
</Plugin>'}
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end
