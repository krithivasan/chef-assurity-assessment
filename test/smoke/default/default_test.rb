# # encoding: utf-8

# Inspec test for recipe assurity-test::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


# mule group exists
describe group('assurity') do
  it { should exist }
end

# mule user exists and is properly configured
describe user('assurity') do
  it { should exist }
  its('group') { should eq 'assurity' }
  its('home') { should eq '/home/assurity' }
  its('shell') { should eq '/bin/bash' }
end

describe service('ufw') do
  it { should be_enabled }
  it { should be_running }
end

describe bash('ufw status') do
  its('stdout') { should match /22/ }
  its('stdout') { should match /ALLOW/ }
  its('stdout') { should match /Status: active/ }
end

describe file('/etc/ssh/sshd_config') do
  it { should be_owned_by 'root' }
  its('content') { should match 'PasswordAuthentication no' }
end

describe file('/etc/update-motd.d/01-motd-assurity') do
  it { should be_owned_by 'root' }
  its('content') { should match 'Hello Assurity DevOps' }
end
