#
# Cookbook Name:: collectd
# Attributes:: default
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

default['collectd']['interval'] = 10
default['collectd']['read_threads'] = 5
default['collectd']['version'] = "5.1.0"
default['collectd']['fqdn_lookup'] = "false"
default['collectd']['server_role'] = "collectd-server"
default['collectd']['install_type'] = "package"
default['collectd']['source_tar_name_prefix'] = "collectd-"
default['collectd']['source_tar_name_extension'] = ".tar.gz"
default['collectd']['source_url_prefix'] = "http://collectd.org/files/"
default['collectd']['checksum'] = "521d4be7df5bc1124b7b9ea88227e95839a5f7c1b704a5bde0f60f058ec6eecb"
default['collectd']['types_db'] = ["/opt/collectd/share/collectd/types.db"]
default['collectd']['prefix_dir'] = "/opt/collectd"
default['collectd']['sysconf_dir'] = "/opt/collectd/etc"
default['collectd']['plugconf_dir'] = "/opt/collectd/etc/plugins"
default['collectd']['bin_dir'] = "/opt/collectd/bin"
default['collectd']['src_dir'] = "/opt/src-collectd"
default['collectd']['sbin_dir'] = "/opt/collectd/sbin"
default['collectd']['log_dir'] = "/opt/collectd/logs"
default['collectd']['plugin_dir'] = "/opt/collectd/lib/collectd"
default['collectd']['ulimit']['file_descriptors'] = "65536"
default['collectd']['build_prereq_pkgs'] = nil
default['collectd']['autoconf_opts'] = nil
