require 'spec_helper'

describe file('/etc/collectd/plugins/disk.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin disk' }
end

describe file('/etc/collectd/plugins/entropy.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin entropy' }
end

describe file('/etc/collectd/plugins/swap.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin swap' }
end

describe file('/etc/collectd/plugins/memory.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin memory' }
end

describe file('/etc/collectd/plugins/rrdtool.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin rrdtool

<Plugin rrdtool>
  DataDir "/var/log/collectd/"
  CacheFlush 120
  WritesPerSecond 50
</Plugin>'}
end

describe file('/etc/collectd/plugins/syslog.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin syslog

<Plugin syslog>
  LogLevel "info"
  NotifyLevel "warning"
</Plugin>'}
end

describe file('/etc/collectd/plugins/tcpconns.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin tcpconns

<Plugin tcpconns>
  ListeningPorts true
</Plugin>'}
end
