name              'chef-assurity-assessment'
maintainer        'Krithivasan B'
maintainer_email  'krithivasanb@gmail.com'
license           'Apache-2.0'
description       'Assurity Technical assessment'
long_description  'Assurity Technical assessment'
version           '0.1.0'
chef_version      '>= 12.1' if respond_to?(:chef_version)

depends 'ssh'
supports          'ubuntu'
