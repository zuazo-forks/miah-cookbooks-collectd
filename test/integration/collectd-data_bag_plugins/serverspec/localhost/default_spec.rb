require 'spec_helper'

describe file('/etc/collectd/plugins/df.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin df' }
end

describe file('/etc/collectd/plugins/load.conf') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'LoadPlugin load' }
end
