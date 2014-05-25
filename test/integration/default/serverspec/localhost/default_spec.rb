
require 'spec_helper'
describe package('collectd-core') do
  it { should be_installed }
end

describe file('/etc/collectd') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into'root' }
end

describe file('/etc/collectd/plugins') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/var/lib/collectd') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/usr/lib/collectd') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/collectd/collectd.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'Hostname "localhost"
FQDNLookup "false"
Interval 10
ReadThreads 5
TypesDB "/usr/share/collectd/types.db"
BaseDir "/usr"
PluginDir "/usr/lib64/collectd"

Include "/etc/collectd/plugins/*.conf"
Include "/etc/collectd/thresholds.conf"'}
end

describe file('/etc/collectd/collection.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'datadir: "/var/lib/collectd/rrd/"
libdir: "/usr/lib/collectd/"'}
end

describe file('/etc/collectd/thresholds.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain '# Threshold configuration for collectd(1).' }
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end
