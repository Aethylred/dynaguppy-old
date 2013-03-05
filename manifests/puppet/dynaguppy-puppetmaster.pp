# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {
  class {'apache': }
  class {'gcc': }
  class {'ruby': }

  class {'puppet':
    pluginsync      => true,
    storeconfigs    => false,
    puppetlabs_repo => true,
    user_shell      => '/bin/bash',
    puppetmaster    => $puppetmaster_fqdn,
  }

  # Allow ssh through the firewall
  firewall { '100 allow ssh':
      state   => ['NEW'],
      dport   => '22',
      proto   => 'tcp',
      action  => 'accept',
  }

  # Set up concat
  include concat::setup

  # Set up a the puppetmaster
  class {'apache::mod::passenger': }
  class {'puppet::master': }

  # set up a basic hiera configuration to stop it reporting errors
  class {'puppet::hiera': }

  class {'git': }

  # For managing key pair distribution use...
  include sshkeys::keymaster

  # Note: keys _must_ be declared in the same
  # environment as the keymaster/puppetmaster, not in the environment
  # of the node that will use them

  # keys for the puppet and git users, these keys are REQUIRED for dynaguppy
  sshkeys::create_key{'puppet_ssh': }
  sshkeys::create_key{'git_ssh': }

  # The puppet user needs the key pair
  sshkeys::set_client_key_pair{'puppet_user_key':
    keyname => 'puppet_ssh',
    user    => $puppet::params::user,
    home    => $puppet::params::user_home,
  }

  # The git user needs to be able to ssh in as the puppet user
  sshkeys::set_authorized_keys{'puppet_key_for_git':
    keyname => 'git_ssh',
    user    => $puppet::params::user,
    home    => $puppet::params::user_home,
  }

  # The puppet user needs to be a git user too
  git::user{$puppet::params::user: }

}
