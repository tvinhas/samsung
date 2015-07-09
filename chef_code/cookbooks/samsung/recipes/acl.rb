#
## Cookbook Name:: samsung
## Recipe:: acl
## Author:: Thiago Vinhas (<thiago@vinhas.net>)
##
#

  directory "/home/ec2-user/.ssh" do
    owner 'ec2-user'
    group 'ec2-user'
    mode '0700'
    action :create
  end

  template "/home/ec2-user/.ssh/authorized_keys" do
    source  'authorized_keys.erb'
    owner   'ec2-user'
    group   'ec2-user'
    mode    '0600'
  end

  template "/etc/sudoers" do
    source  'sudoers.erb'
    owner   'root'
    group   'root'
    mode    '0440'
  end


  if File.readlines("/etc/ssh/sshd_config").grep(/#Port 22/).size > 0
       execute "Changing SSH port" do
         command 'sed -E -i \'s/#Port 22/Port 10022/\' /etc/ssh/sshd_config'
         action :run
       end
  end

