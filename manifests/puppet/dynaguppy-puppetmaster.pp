# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {
	class {'apache': }
	class {'gcc': }
	class {'ruby': }
	class {'passenger':	
		require	=> Class['apache','gcc','ruby'],
	}

	class {'puppet':
		pluginsync 			=> true,
		storeconfig 		=> true,
		puppetlabs_repo => true,
		user_shell			=> '/bin/bash',
	}

	class {'git': }

	# For managing rsa key pair distribution use...
	include sshkey
	include sshkey::keymaster

	# Note keys _must_ be declared in the same
	# environment as the keymaster/puppetmaster, not in the environment
	# of the node that will use them

	# declare the key for the puppet user, which is declared in the puppet module
	sshkey::key{'puppet':
		user 	=> $puppet::params::user,
		home	=> $puppet::params::user_home,
		require => User['puppet'],
	}


}