#
## Cookbook Name:: samsung
## Recipe:: confs
## Author:: Thiago Vinhas (<thiago@vinhas.net>)
#

  if File.readlines("/etc/httpd/conf/httpd.conf").grep(/Listen 80/).size > 0
    execute "Change HTTP port" do
    command 'sed -E -i \'s/Listen 80/Listen 10080/\' /etc/httpd/conf/httpd.conf'
    action :run
    notifies :restart, 'service[httpd]'
    end
  end

  template "/etc/httpd/conf.d/graphite-httpd.conf" do
    source  'graphite-httpd.conf.erb'
    owner   'root'
    group   'root'
    mode    '0644'
    notifies :restart, 'service[httpd]'
  end

  template "/opt/graphite/conf/graphite.wsgi" do
    source  'graphite.wsgi.erb'
    owner   'root'
    group   'root'
    mode    '0755'
  end

  template "/opt/graphite/webapp/graphite/local_settings.py" do
    source  'local_settings.py.erb'
    owner   'root'
    group   'root'
    mode    '0644'
  end

  template "/opt/graphite/conf/storage-schemas.conf" do
    source  'storage-schemas.conf.erb'
    owner   'root'
    group   'root'
    mode    '0644'
  end

  template "/opt/graphite/conf/carbon.conf" do
    source  'carbon.conf.erb'
    owner   'root'
    group   'root'
    mode    '0644'
    notifies :restart, 'service[carbon-cache]'
  end

  template "/etc/collectd.conf" do
    source  'collectd.conf.erb'
    owner   'root'
    group   'root'
    mode    '0644'
    notifies :restart, 'service[collectd]'
  end

  template "/etc/init.d/carbon-cache" do
    source  'carbon-cache.erb'
    owner   'root'
    group   'root'
    mode    '0755'
  end

  template "/var/www/error/403.html" do
    source  '403.html.erb'
    owner   'root'
    group   'root'
    mode    '0644'
  end

  template "/var/www/error/403.png" do
    source  '403.png.erb'
    owner   'root'
    group   'root'
    mode    '0644'
  end

  template "/opt/graphite/webapp/content/stats/index.html" do
    source  'index-stats.html.erb'
    owner   'root'
    group   'root'
    mode    '0644'
  end
