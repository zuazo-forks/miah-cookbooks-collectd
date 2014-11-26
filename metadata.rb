maintainer 'Miah Johnson'
maintainer_email 'miah@chia-pet.org'
license 'Apache 2.0'
name 'collectd'
description 'Install and configure the collectd monitoring daemon'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.0'

%w( ubuntu centos ).each { |os| supports os }
%w( apt build-essential logrotate runit yum-epel ).each { |cookbook| depends cookbook }
depends 'ark', '~> 0.2'
