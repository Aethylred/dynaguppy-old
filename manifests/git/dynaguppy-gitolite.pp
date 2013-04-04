# This node defines the dynaguppy gitolite repository

# Defines the dynaguppy gitolite server,

node 'git.local' {

  #class {'firewall':}

  # Allow ssh through the firewall
  firewall { '100 allow ssh':
      state   => ['NEW'],
      dport   => '22',
      proto   => 'tcp',
      action  => 'accept',
  }

  class {'puppet':
    pluginsync      => true,
    storeconfigs    => false,
    puppetlabs_repo => true,
    user_shell      => '/bin/bash',
    puppetmaster    => $puppetmaster_fqdn,
  }

  class {'git': }

  user{'git':
    ensure      => present,
    shell       => '/bin/bash',
    home        => '/home/git',
    managehome  => true,
    require     => Class['git'],
  }

  # The git user needs a key pair
  sshkeys::set_client_key_pair{'git_user_key':
    keyname => 'git_ssh',
    user    => 'git',
    home    => '/home/git',
  }

  # the git user needs to be a git user
  git::user{'git': }

  class{'gitolite':
    user      => 'git',
    group     => $apache::params::group,
    base_dir  => '/home/git',
    repo_dir  => "${base_dir}/repositories",
    require   => [Git::User['git']]
  }

}