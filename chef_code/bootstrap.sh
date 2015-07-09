#!/bin/bash -xe
 
 
# Checks to see if being run by root

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Type \'sudo su -\' and try again." 1>&2
   exit 1
fi

# Install Chef and its dependencies
#yum-config-manager --enable epel
yum update -y
yum install -y gcc automake autoconf libtool make ruby ruby-devel ruby-docs ruby-ri ruby-rdoc rubygems git
 
# Install chef-solo
gem install chef ruby-shadow --no-ri --no-rdoc
 
mkdir /etc/chef

 echo '
  file_cache_path "/root/chef_code"
  cookbook_path "/root/chef_code/cookbooks"
  json_attribs "/etc/chef/node.json"
' > /etc/chef/solo.rb

 echo '
{
  "run_list": [ "recipe[samsung]" ]
}
' > /etc/chef/node.json

#git clone https://github.com/hw-cookbooks/graphite /root/chef_code/cookbooks
