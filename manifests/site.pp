# The primary site manifest

# Set the names for the key servers in the dynaguppy setup

$puppetmaster_fqdn = 'puppet.local'
$git_fqdn	= 'git.local'

# Configure the firewall defaults as per https://github.com/puppetlabs/puppetlabs-firewall
# Always persist firewall rules
exec { 'persist-firewall':
  command     => $operatingsystem ? {
    /(Debian|Ubuntu)/ => '/sbin/iptables-save > /etc/iptables/rules.v4',
    /(RedHat|CentOS)/ => '/sbin/iptables-save > /etc/sysconfig/iptables',
  },
  refreshonly => true,
}

# These defaults ensure that the persistence command is executed after 
# every change to the firewall, and that pre & post classes are run in the
# right order to avoid potentially locking you out of your box during the
# first puppet run.
Firewall {
  notify  => Exec['persist-firewall'],
  before  => Class['my_fw::post'],
  require => Class['my_fw::pre'],
}
Firewallchain {
  notify  => Exec['persist-firewall'],
}

# Purge unmanaged firewall resources
#
# This will clear any existing rules, and make sure that only rules
# defined in puppet exist on the machine
resources { "firewall":
  purge => true
}

# These subdirectories are required for dynaguppy
import "./puppet/*"
import "./git/*"

# Add other manifest subdirectories here