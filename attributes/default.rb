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

default[:collectd][:version] = "5.1.0"
default[:collectd][:release_uri] = "http://collectd.org/files/collectd-5.1.0.tar.bz2"
default[:collectd][:prefix] = "/opt/collectd"
default[:collectd][:sysconfdir] = "/etc/collectd"
default[:collectd][:base_dir] = "/var/lib/collectd"
default[:collectd][:confd_dir] = "/etc/collectd.d"
default[:collectd][:plugins_dir] = "/usr/lib/collectd"
default[:collectd][:types_db] = ["/usr/share/collectd/types.db"]
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
default[:collectd][:plugins_enabled] = "--enable-write_graphite"
default[:collectd][:redis_enabled] = 0
