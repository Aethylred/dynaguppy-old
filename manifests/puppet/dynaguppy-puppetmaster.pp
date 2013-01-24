# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {

# These conflict with the installation of the puppetlabs/gcc module with puppet-librarian
	# package{['ruby-dev','build-essential']:
	# 	ensure		=> installed,
	# }

	file{'/etc/puppet/modules':
		ensure	=> directory,
	}

	exec{'dynaguppy_bootstrap_gcc':
		command	=> 'puppet module install puppetlabs/gcc',
		cwd			=> '/etc/puppet/modules',
		require	=> File['/etc/puppet/modules'],
		creates	=> '/etc/puppet/modules/gcc',
	}

	class {'gcc':
		require => Exec['dynaguppy_bootstrap_gcc'],
	}

# maestrodev has some patches we need!

	package{'librarian-puppet-maestrodev':
		ensure		=> latest,
		provider	=> gem,
		require		=> Package['ruby-dev','build-essential']
	}

	exec{'initialise_modules':
		path		=> ["/usr/local/bin","/usr/bin"],
		environment	=> ["HOME=/root"],
		cwd			=> "/etc/puppet",
		command		=> "librarian-puppet install",
		creates 	=> "/etc/puppet/modules/stdlib",
		require 	=> Package['librarian-puppet-maestrodev'],
		timeout 	=> 300,
	}

	class {'apache': }
	class {'ruby': }
	class {'passenger':	
	require	=> Class['apache','gcc','ruby'],
	}

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