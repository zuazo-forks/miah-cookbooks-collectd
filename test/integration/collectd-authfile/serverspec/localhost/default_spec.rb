require 'spec_helper'

describe file('/etc/collectd/authfile') do
  it { should be_file }
  it { should be_mode 600 }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should contain 'manny: viva_la_mexico
hector: the_hulk'}
  it { should_not contain 'bob' }
end
