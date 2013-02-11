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

	class {'puppet::hiera':
		hiera_hierarchy => ['common','user-%{user}'],
	}

	class {'git': }

	# # For managing rsa key pair distribution use...
	# include sshauth
	# include sshauth::keymaster

	# # Note keys _must_ be declared in the same
	# # environment as the keymaster/puppetmaster, not in the environment
	# # of the node that will use them

	# # declare the key for the puppet user, which is declared in the puppet module
	# sshauth::key{'puppet':
	# 	user 	=> $puppet::params::user,
	# 	home	=> $puppet::params::user_home,
	# 	require => User['puppet'],
	# }


}