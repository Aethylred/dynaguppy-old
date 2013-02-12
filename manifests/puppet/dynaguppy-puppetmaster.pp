# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {
	class {'apache': }
	class {'gcc': }
	class {'ruby': }

	# Let's work with the Puppetlabs Apache module version first...
	# class {'passenger':	
	# 	require	=> Class['apache','gcc','ruby'],
	# }

	class {'apache::mod::passenger': }

	class {'puppet':
		pluginsync 			=> true,
		storeconfigs 		=> true,
		puppetlabs_repo => true,
		user_shell			=> '/bin/bash',
	}

	# set up a basic hiera configuration to stop it reporting errors
	class {'puppet::hiera':	}

	class {'git': }

	# For managing key pair distribution use...
  include sshkeys::keymaster

	# Note keys _must_ be declared in the same
	# environment as the keymaster/puppetmaster, not in the environment
	# of the node that will use them

	# keys for the puppet and git users
	sshkeys::create_key{'puppet_ssh':	}
	sshkeys::create_key{'git_ssh': }

}