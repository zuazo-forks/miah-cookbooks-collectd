if defined?(ChefSpec)
  def create_collectd_plugin(options)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_plugin, :create, options)
  end

  def delete_collectd_plugin(options)
    ChefSpec::Matchers::ResourceMatcher.new(:collectd_plugin, :delete, options)
  end
end
