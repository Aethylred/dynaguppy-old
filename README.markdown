# dynaguppy

DYNAmic Git pUPPet... Yeah...

# Installation

1. Ideally start with a freshly installed Ubuntu 12.04 x86_64 Server
1. Log in as `root`
1. Install `puppet` with:

    # apt-get install puppet

1. Install `git` with:

    # apt-get install git

1. Change to the Puppet configuration directory

    # cd /etc/puppet

1. Initialise the Puppet configuration directory as a git working directory:

    # git init

1. Set the dynaguppy on GitHup as a read-only remote repository:

		# git remote add upstream git://github.com/Aethylred/dynaguppy.git

1. Retieve the dynaguppy initial configuration

		# git pull --force upstream master

1. Ensure that the `master` branch is checked out:

    # git checkout --force master

1. Update all require submodules:

		# git submodule update --init --recursive

1. Copy the example dynaguppy configuration to create a new configuration:

    # cp manifests/dynaguppy_conf.pp.example manifests/dynaguppy_conf.pp

1. Edit /etc/puppet/manifests/dynaguppy_conf.pp and set at least new settings for *$dynaguppy_puppetmaster* and *$dynaguppy_gitolite* (Do not add the new configuration to version control until asked!)

Much of ths could be converted into a script later...

# Licensing

Written by Aaron Hicks (hicksa@landcareresearch.co.nz) for the New Zealand eScience Infrastructure.

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/"><img alt="Creative Commons Licence" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>