# This sets up the default 'wrapper' around the firewall module
# that makes the firewall persisitant
#
# Check the readme at:
# https://github.com/puppetlabs/puppetlabs-firewall/blob/master/README.markdown

class dynaguppy::firewall::persist{

  # These defaults ensure that the persistence command is executed after
  # every change to the firewall, and that pre & post classes are run in the
  # right order to avoid potentially locking you out of your box during the
  # first puppet run.
  Firewall {
    before  => Class['dynaguppy::firewall::post'],
    require => Class['dynaguppy::firewall::pre'],
  }

  # Purge unmanaged firewall resources
  #
  # This will clear any existing rules, and make sure that only rules
  # defined in puppet exist on the machine
  resources { "firewall":
    purge => true
  }
}