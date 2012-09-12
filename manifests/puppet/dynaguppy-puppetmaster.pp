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
		pluginsync => true,
		storeconfig => true,
		puppetlabs_repo => true,
	}

	# For Dynaguppy to work, the puppet user needs to be able to log
	# in remotely with ssh
	user{'puppet':
		ensure	=> present,
		shell 	=> '/bin/bash',
		require	=> Class['puppet'],
	}
	
	class {'git': }

	# For managing rsa key pair distribution use...
	include sshkey
	include sshkey::keymaster

	# Note keys _must_ be declared in the same
	# environment as the keymaster/puppetmaster, not in the environment
	# of the node that will use them

	# declare the key for the puppet user

	sshkey::key{'puppet':
		user 	=> $puppet::params::user,
		home	=> $puppet::params::user_home,
	}


}