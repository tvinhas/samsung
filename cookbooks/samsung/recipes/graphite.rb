#
## Cookbook Name:: samsung
## Recipe:: graphite
## Author:: Thiago Vinhas (<thiago@vinhas.net>)
#

  execute 'Install Django' do
    command "pip install Django==1.7.8"
    not_if { ::File.exists?("/usr/local/lib/python2.7/site-packages/django/bin/django-admin.py")}
  end

  execute 'Install django-tagging' do
    command "pip install django-tagging"
    not_if { ::File.exists?("/usr/local/lib/python2.7/site-packages/django_tagging-0.4.dist-info")}
  end

  execute 'Install whisper' do
    command "pip install whisper"
    not_if { ::File.exists?("/usr/local/lib/python2.7/site-packages/whisper.py")}
  end

  execute 'Install carbon' do
    command "pip install carbon"
    not_if { ::File.exists?("/opt/graphite/bin/carbon-client.py")}
  end

  execute 'Install Graphite' do
    command "pip install graphite-web"
    not_if { ::File.exists?("/opt/graphite/webapp/graphite/storage.py")}
  end

  directory '/opt/graphite/storage' do
    owner 'apache'
    group 'apache'
    mode '0700'
  end

  execute 'Populate initial database' do
    command "PYTHONPATH=/opt/graphite/webapp django-admin.py syncdb --settings=graphite.settings --noinput ; chown apache: /opt/graphite/storage/graphite.db"
    not_if { ::File.exists?("/opt/graphite/storage/graphite.db")}
  end

  directory '/opt/graphite/webapp/content/stats' do
    recursive true
    action :create
  end


