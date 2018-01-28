# Attributes

# Set default home path
default['chef_assurity_assessment']['home'] = '/home/assurity'

# User
default['chef_assurity_assessment']['user'] = 'assurity'

# Define the service name for sshd
case node['platform_family']
when 'rhel', 'fedora', 'suse', 'freebsd', 'gentoo', 'amazon'
  default['chef_assurity_assessment']['ssh']['service_name'] = 'sshd'
else
  default['chef_assurity_assessment']['ssh']['service_name'] = 'ssh'
end

# Users public key
default['chef_assurity_assessment']['public_key'] = 'AAAAB3NzaC1yc2EAAAADAQABAAACAQDLT0qJACtHZGabtUuGGEwu1R19LXmwa8D9s+SDm+rXVez4eDvlzICHxsPKX8by4rWznJifeZtzJ/Xu10zG/t2Y8trtf3lJ0il0yKZhIkW9AMxtY4/ZsYH3msGOvhUvp/+4NvlAKaIsr0YB3Dvfzl2W1Lhx9kkEpwXLLZF7h2fkNaPMYvG19+bjB34s+SoB+ohzbOoiSaOcPYrY8uMCKicU1JWWTWdDyBhAM6ZP9xWKr2T8k1NFNFRUsoEKPe7/PaN2BFWdY5RDOzg4DUEJiS18UzWwu25RbcHnetI8ioQ3+8SFetWWGStR48uwfUeGvn81Ij/t0BMRm9yyVsbjmZ/RaKLlbmdFcGB1Yh/Dg7J4UMsgOiWdiuuX+gja4ldceaKGY89rBWbSfaFOLJuG1OVF77I21uoId2QnnjisWUbD9LjFQfbzZgX8HcprVGyiNiK9nQN2WOUK4SuwKvaArd2Z+nPh2gpxbfC2+Wg0Kc4IGH89tNEUyNd2LMEPXsiiqr59V+28pLsiG+ls2bCHgZBheISk6uh1A3A5IZXEJggGMC8/73v70+GKsjDkDOAFQkcksYSkT0Ic1pIQoEXtKNfyzknZuqyg4+Vdk+niFHz3fqG+5MhcoMt7fx3qznl4ANntl9pGOfYuq5FVjMU9N7UEywi8MnK6qPo43ZT9y+4Kpw=='

# ssh key type
default['chef_assurity_assessment']['ssh_key_type'] = 'ssh-rsa'

# ssh key comment
default['chef_assurity_assessment']['ssh_key_comment'] = 'techAssessment'
