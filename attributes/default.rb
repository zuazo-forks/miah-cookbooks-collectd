#
# Cookbook Name:: collectd
# Attributes:: default
#
# Copyright 2012, Scott M. Likens
# Copyright 2010, Atari, Inc
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default[:collectd][:git_url] = "https://github.com/collectd/collectd.git"
default[:collectd][:git_branch] = "master"
default[:collectd][:prefix] = "/opt/collectd"
default[:collectd][:sysconfdir] = "/opt/collectd/etc"
default[:collectd][:base_dir] = "/opt/collectd/var/lib/collectd"
default[:collectd][:confd_dir] = "/opt/collectd/conf.d"
default[:collectd][:plugins_dir] = "/opt/collectd/lib/collectd"
default[:collectd][:types_db] = ["/opt/collectd/share/collectd/types.db", "/opt/collectd/share/collectd/haproxy.db" ]
default[:collectd][:interval] = 10
default[:collectd][:read_threads] = 5
default[:collectd][:graphite_host] = "localhost"
default[:collectd][:graphite_port] = "2003"
default[:collectd][:graphite_prefix] = "collectd"
default[:collectd][:graphite_postfix] = "collectd"
default[:collectd][:graphite_storerates] = "false"
default[:collectd][:graphite_alwaysappendds] = "false"
default[:collectd][:graphite_escapecharecter] = "_"
default[:collectd][:configure_parameters] = String.new
default[:collectd][:plugins_enabled] = "--enable-write_graphite --enable-redis --with-libcredis=/usr/local/credis-0.2.3"
