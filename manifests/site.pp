# The primary site manifest

# Set the names of the puppet and git server (should be in hiera!)
$puppetmaster_fqdn = 'puppet.local'
$git_fqdn = 'git.local'

# These subdirectories are required for dynaguppy
import "./puppet/*"
import "./git/*"

# Add other manifest subdirectories here