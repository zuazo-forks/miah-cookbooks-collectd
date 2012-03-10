# REASON FOR FORK #

I Forked this cookbook to faciliate a function: Collectd writing to graphite monitoring redis and haproxy.  Your milage may vary.


# DESCRIPTION #

Configure and install the [collectd](http://collectd.org/) monitoring daemon.

# REQUIREMENTS #

This cookbook has only been tested on Ubuntu 10.04.

To use the `collectd::collectd_web` recipe you need the [apache2](https://github.com/opscode/cookbooks/tree/master/apache2) cookbook.

The [collectd_plugins](#) cookbook is not required, but provides many common plugin definitions for easy reuse.

# REASON FOR THIS FORK #

* This cookbook brings in collectd from [master][1] to provide the ability to write to graphite.  RRD is disabled by default as that is the whole point of this cookbook.


# ATTRIBUTES #

* collectd.basedir - Base folder for collectd output data.
* collectd.plugin_dir - Base folder to find plugins.
* collectd.types_db - Array of files to read graph type information from.
* collectd.interval - Time period in seconds to wait between data reads.
* collectd.graphite_url - Endpoint for Graphite.  **Must** be defined for [usage][2].

# USAGE #

one recipe is provided:

* collectd - Install a standalone daemon.

The client recipe will use the search index to automatically locate the server hosts, so no manual configuration is required.

## Defines ##

Several defines are provided to simplfy configuring plugins

### collectd_plugin ###

The `collectd_plugin` define configures and enables standard collect plugins. Example:

```ruby
collectd_plugin "interface" do
  options :interface=>"lo", :ignore_selected=>true
end
```

The options hash is converted to collectd-style settings automatically. Any symbol key will be converted to camel-case. In the above example :ignore_selected will be output as the
key "IgnoreSelected". If the key is already a string, this conversion is skipped. If the value is an array, it will be output as a separate line for each element.

### collectd_python_plugin ###

The `collectd_python_plugin` define configures and enables Python plugins using the collectd-python plugin. Example:

```ruby
collectd_python_plugin "redis" do
  options :host=>servers, :verbose=>true
end
```

Options are interpreted in the same way as with `collectd_plugin`. This define will not deploy the plugin script as well, so be sure to setup a cookbook_file resource
or other mechanism to handle distribution. Example:

```ruby
cookbook_file File.join(node[:collectd][:plugin_dir], "redis.py") do
  owner "root"
  group "root"
  mode "644"
end
```

## Web frontend ##

The `collectd::collectd_web` recipe will automatically deploy the [collectd_web](https://github.com/httpdss/collectd-web) frontend using Apache. The 
[apache2](https://github.com/opscode/cookbooks/tree/master/apache2) cookbook is required for this and is *not* included automatically as this is an optional
component, so be sure to configure the node with the correct recipes.

# LICENSE & AUTHOR #

Author:: Scott M. Likens (<scott@likens.us>)
Author:: Noah Kantrowitz (<noah@coderanger.net>)
Copyright:: 2012, Scott M. Likens
copyright:: 2010, Atari, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[1]: https://github.com/collectd/collectd
[2]: https://github.com/damm/chef-collectd/tree/master/attributes/default.rb
