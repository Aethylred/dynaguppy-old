# This node defines your dynaguppy puppetmaster

# Defines the dynaguppy puppetmaster,

node 'puppet.local' {
  include concat::setup
  class {'gcc': }
  class {'ruby': }

  class {'puppet':
    pluginsync      => true,
    storeconfigs    => false,
    puppetlabs_repo => true,
    user_shell      => '/bin/bash',
    puppetmaster    => $puppetmaster_fqdn,
  }


  # Set up the puppetmaster on passenger
  class {'apache': }
  class {'apache::mod::passenger':
    passenger_high_performance    => 'off',
    passenger_max_pool_size       => 12,
    passenger_pool_idle_time      => 1500,
    # passenger_max_requests        => 1000,
    passenger_stat_throttle_rate  => 120,
    rack_autodetect               => 'off',
    rails_autodetect              => 'off',
  }
  class {'puppet::master': }

  # set up a basic hiera configuration to stop it reporting errors
  class {'puppet::hiera': }

  class {'git': }


}