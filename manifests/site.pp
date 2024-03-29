# The primary site manifest

# Set the names for the key servers in the dynaguppy setup

$puppetmaster_fqdn = 'puppet.local'
$git_fqdn = 'git.local'

# Configure the firewall to be persistant
# as per https://github.com/puppetlabs/puppetlabs-firewall
# wrapped up in a convienent class
include dynaguppy::firewall

# These subdirectories are required for dynaguppy
import "./puppet/*"
import "./git/*"

# Add other manifest subdirectories here