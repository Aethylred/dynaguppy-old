# dynaguppy

DYNAmic Git pUPPet... Yeah...

# Installation

1. Ideally start with a freshly installed Ubuntu 12.04 x86_64 Server
1. Log in as `root`
1. Install `puppet` with:

    apt-get install puppet

1. Install `git` with:

    apt-get install git

1. Change to the Puppet configuration directory

    cd /etc/puppet

1. Initialise the Puppet configuration directory as a git working directory:

    git init

1. Set the dynaguppy on GitHup as a read-only remote repository:

  git remote add upstream git://github.com/Aethylred/dynaguppy.git

1. Retieve the dynaguppy initial configuration

  git pull --force upstream master

1. Ensure that the `master` branch is checked out:

    git checkout --force master

1. Update all require submodules:

  git submodule update --init --recursive

1. Copy the example dynaguppy puppet node configuration to create a new configuration:

    cp manifests/puppet/puppet.pp.example manifests/puppet/puppet.pp

1. Edit `/etc/puppet/manifests/puppet/puppet.pp` and at least change the name of the puppetmaster node to the `$fqdn` of the puppetmaster

Much of ths could be converted into a script later...

# References

The use of git to manage Puppet environments theme was mangled together from these articles and projects:
* http://puppetlabs.com/blog/git-workflow-and-puppet-environments/
* http://sjoeboo.github.com/blog/2012/02/08/moving-puppet-from-subversion-to-git-in-15-minutes-while-adding-dynamic-environments/#disqus_thread
* https://github.com/pdxcat/puppetsync
* https://github.com/adrienthebo/puppet-git-hooks
* http://hunnur.com/blog/2010/10/dynamic-git-branch-puppet-environments/

# Licensing

Written by Aaron Hicks (hicksa@landcareresearch.co.nz) for the New Zealand eScience Infrastructure.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons Licence" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>