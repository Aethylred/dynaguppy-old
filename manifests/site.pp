# The primary site manifest

# Set the names for the key servers in the dynaguppy setup

$puppetmaster_fqdn = 'puppet.local'
$git_fqdn	= 'git.local'

# These subdirectories are required for dynaguppy
import "./puppet/*"
import "./git/*"

# Add other manifest subdirectories here