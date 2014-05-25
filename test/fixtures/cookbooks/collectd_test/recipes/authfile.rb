include_recipe 'collectd'

collectd_authfile 'manny' do
  password 'viva_la_mexico'
end

collectd_authfile 'hector' do
  password 'the_hulk'
end

collectd_authfile 'bob' do
  password 'sea_hash'
end

collectd_authfile 'bob' do
  action :remove
end
