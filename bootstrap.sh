#!/bin/bash


# Checks to see if being run by root

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root. Type \'sudo su -\' and try again." 1>&2
   exit 1
fi

# Update packages and install Chef and its dependencies
yum update -y
yum install -y libtool ruby ruby-devel rubygems git

# Install cookbook 
if [ ! -d /root/chef_code ]             
  then
    mkdir /root/chef_code
fi

rm -fR {/tmp/git,/root/chef_code/cookbooks}
git clone https://github.com/tvinhas/samsung /tmp/git ; mv -fu /tmp/git/cookbooks /root/chef_code/cookbooks ; rm -fR /tmp/git

# Install chef-solo
gem install chef ruby-shadow --no-ri --no-rdoc

if [ ! -d /etc/chef ]      
  then
    mkdir /etc/chef
fi

 echo '
  file_cache_path "/tmp"
  cookbook_path "/root/chef_code/cookbooks"
  json_attribs "/etc/chef/node.json"
' > /etc/chef/solo.rb

 echo '
{
  "run_list": [ "recipe[samsung]" ]
}
' > /etc/chef/node.json

chef-solo
