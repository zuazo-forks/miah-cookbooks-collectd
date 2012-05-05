maintainer       "Miah Johnson"
maintainer_email "miah@chia-pet.org"
license          "Apache 2.0"
description      "Install and configure the collectd monitoring daemon"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"
supports         "ubuntu"

%w[ build-essential ark runit ].each do |cookbook|
  depends cookbook
end
