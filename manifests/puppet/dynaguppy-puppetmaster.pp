# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {

	package{'librarian-puppet':
		ensure		=> latest,
		provider	=> gem,
	}

	exec{'initialise_modules':
		path		=> "/usr/local/bin",
		command	=> "librarian-puppet init",
		creates => "/etc/puppet/modules/stdlib"
	}

	# class {'apache': }
	# class {'gcc': }
	# class {'ruby': }
	# class {'passenger':	
	# 	require	=> Class['apache','gcc','ruby'],
	# }

	# class {'puppet':
	# 	pluginsync 			=> true,
	# 	storeconfigs 		=> true,
	# 	puppetlabs_repo => true,
	# 	user_shell			=> '/bin/bash',
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
	# 	user 	=> $puppet::params::user,
	# 	home	=> $puppet::params::user_home,
	# 	require => User['puppet'],
	# }


}