# This node defines the dynaguppy gitolite repository

# Defines the dynaguppy gitolite server,

node 'git.local' {

	class {'puppet':
		pluginsync 			=> true,
		storeconfigs 		=> false,
		puppetlabs_repo => true,
		user_shell			=> '/bin/bash',
		puppetmaster 		=> $puppetmaster_fqdn,
	}

	class {'git': }

	user{'git':
		ensure			=> present,
		shell				=> '/bin/bash',
		home				=> '/home/git',
		managehome	=> true,
		require			=> Class['git'],
	}

	# The git user needs a key pair
	sshkeys::set_client_key_pair{'puppet_user_key':
		keyname	=> 'git_ssh',
		user 		=> 'git',
		home		=> '/home/git',
	}

	# the git user needs to be a git user
	git::user{'git': }
	
}