#
# Cookbook Name:: chef_assurity_assessment
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - feel free to Redistribute
#


# Create a user to login to the box
user "assurity" do
  home node['chef_assurity_assessment']['home']
  shell "/bin/bash"
end

# Create a group for the user created above
group "assurity" do
  members "assurity"
  action :create
end

# Create the home directory for the user
directory node['chef_assurity_assessment']['home']  do
  owner "assurity"
  group "assurity"
  mode 0744
  action :create
end

# Create the .ssh directory for the user
directory "#{node['chef_assurity_assessment']['home']}/.ssh" do
  owner "assurity"
  group "assurity"
  mode 0744
  action :create
end

ssh_authorized_keys "for remote access" do
  user node['chef_assurity_assessment']['user']
  key node['chef_assurity_assessment']['public_key']
  type node['chef_assurity_assessment']['ssh_key_type']
  comment node['chef_assurity_assessment']['ssh_key_comment']
end

# Update the sshd_config to disable password authentication
cookbook_file "/etc/ssh/sshd_config" do
  source "sshd_custom_config"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[sshd]'
end

service 'sshd' do
  # use upstart for ubuntu, otherwise chef uses init
  case node['platform']
  when 'ubuntu'
    if node['platform_version'].to_f >= 15.04
      provider Chef::Provider::Service::Systemd
    elsif node['platform_version'].to_f >= 12.04
      provider Chef::Provider::Service::Upstart
    end
  end
  service_name node['chef_assurity_assessment']['ssh']['service_name']
  supports value_for_platform(
    'centos' => { 'default' => %i[restart reload status] },
    'redhat' => { 'default' => %i[restart reload status] },
    'fedora' => { 'default' => %i[restart reload status] },
    'scientific' => { 'default' => %i[restart reload status] },
    'arch' => { 'default' => [:restart] },
    'debian' => { 'default' => %i[restart reload status] },
    'ubuntu' => {
      '8.04' => %i[restart reload],
      'default' => %i[restart reload status]
    },
    'default' => { 'default' => %i[restart reload] }
  )
  action %i[enable start]
end

# Cleanup the default MOTD Files
execute "Cleanup-default-motd-files" do
  cwd "/etc/update-motd.d"
  user "root"
  command "rm -f *"
  not_if "ls motd-assurity-devops"
end

# Update the motd file to display custom message
cookbook_file "/etc/update-motd.d/motd-assurity-devops" do
  source "motd-assurity-devops"
  owner "root"
  group "root"
  mode 0755
end

# Enable the firewall if not already started
execute "enable-firewall" do
  user "root"
  command "ufw --force enable"
  only_if "ufw status | grep inactive | grep -v grep"
end

# Enable the ssh port 22
execute "enable-ssh-port" do
  user "root"
  command "ufw allow 22"
end
