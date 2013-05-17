# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {
  include concat::setup
  class {'gcc': }
  class {'ruby': }
  class {'apache': }
  class {'apache::mod::passenger': }
  # class {'passenger': 
  # require => Class['apache','gcc','ruby'],
  # }

  # class {'puppet':
  #   pluginsync      => true,
  #   storeconfigs    => true,
  #   puppetlabs_repo => true,
  #   user_shell      => '/bin/bash',
  # }

  # class {'git': }

  # # For managing rsa key pair distribution use...
  # include sshauth
  # include sshauth::keymaster

  # # Note keys _must_ be declared in the same
  # # environment as the keymaster/puppetmaster, not in the environment
  # # of the node that will use them

  # # declare the key for the puppet user, which is declared in the puppet module
  # sshauth::key{'puppet':
  #   user  => $puppet::params::user,
  #   home  => $puppet::params::user_home,
  #   require => User['puppet'],
  # }


}