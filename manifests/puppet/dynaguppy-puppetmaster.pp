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
	}
	
	class {'git': }
}