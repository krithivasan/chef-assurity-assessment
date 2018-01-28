# Cookbook - assurity-test

This cookbook performs a series of tasks on an ubuntu server.


* Carry out any configuration steps needed to allow login over ssh, securely and disable password based login
* Set up the firewall to only allow ingress on the ssh port and
* only to allow password-less (certificate) based login
* Display the MOTD including the text "Hello Assurity DevOps".

## execution steps

```ruby
bundle install
bundle exec berks install
rake style
bundle exec kitchen test
```
