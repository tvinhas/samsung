#
## Cookbook Name:: samsung
## Recipe:: default
## Author:: Thiago Vinhas (<thiago@vinhas.net>)
##
#
  pkgs = [ 'httpd', 'python27-pycairo', 'python27-pytz', 'mod_wsgi-python27', 'rrdtool-python27', 'fontconfig', 'collectd' ]
  pkgs.each{|p|package p}



  include_recipe 'samsung::acl'

#  include_recipe 'samsung::graphite'

#  include_recipe 'samsung::confs'

#  service "httpd" do
#    supports :start => true, :reload => true
#    action [ :enable, :start ]
#  end
#
#  service "carbon-cache" do
#    supports :start => true, :reload => true
#    action [ :enable, :start ]
#  end
#
#  service "collectd" do
#    supports :start => true, :reload => true
#    action [ :enable, :start ]
#  end
