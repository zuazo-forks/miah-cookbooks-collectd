
require 'spec_helper'

describe file('/etc/collectd/plugins/write_graphite.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin "write_graphite"

<Plugin "write_graphite">
  <Carbon>
  Host "127.0.0.1"
  Port 2003
  Prefix "collectd."
  EscapeCharacter "_"
  StoreRates false
  </Carbon>
</Plugin>'}
end

describe service('collectd') do
  it { should be_enabled }
  it { should be_running }
end
