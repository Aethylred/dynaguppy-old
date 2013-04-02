# dynaguppy

DYNAmic Git pUPPet... Yeah...

The intention of this project is to use git to deploy puppet to deploy puppet to deploy git to maintain puppet. After the install process it should result in two servers, a puppet server and a git server, that provide a puppetmaster with dynamic environments managed from a git repository on the git server, where each branch on the puppet configuration repository maps to an environment in the Puppet configuration.

# Installation

## The Puppet Master

By default the PuppetMaster uses the name `puppet.local`

1. Ideally start with a freshly installed Ubuntu Server, 12.04 x86_64 or later
1. Log in as `root`
1. Install `puppet` with:

    ```
    apt-get install puppet
    ```
1. Install `git` with:

    ```
    apt-get install git
  ```
1. Change to the Puppet configuration directory

  ```
    cd /etc/puppet
    ```
1. Initialise the Puppet configuration directory as a git working directory:

  ```
    git init
    ```
1. Set the dynaguppy on GitHup as a read-only remote repository:

  ```
  git remote add upstream git://github.com/Aethylred/dynaguppy.git
  ```
1. Retrieve the dynaguppy initial configuration

  ```
    git pull --force upstream master
  ```
1. Ensure that the `master` branch is checked out:

  ```
    git checkout --force master
  ```

  **Note:** Master will be latest stable release, you may consider using a tag for a specific known version of dynaguppy.
1. Update all require submodules:

  ```
    git submodule update --init --recursive
  ```
1. Edit `/etc/puppet/manifests/puppet/dynaguppy-puppet.pp` and at least change the name of the  node to the `$fqdn` of the server dynaguppy is being configured.
1. Commit your changes:

  ```
  git commit -am "First changes after cloning dynaguppy from source"
  ```
1. Apply the puppet configuration:

  ```
  puppet apply /etc/puppet/manifests/site.pp
  ```

  **Note:** This may need to be repeated a couple of times to resolve all outstanding puppet dependencies.

1. Verify that the puppetmaster is running:

  ```
  puppet agent --test
  ```

  **Note:** It may be necessary to register the puppetmaster with itself.

## The Git repository

The default name for the git repository is `git.local`, the PuppetMaster needs to be up and running first.

1. Ideally start with a freshly installed Ubuntu Server, 12.04 x86_64 or later
1. Log in as `root`
1. Install `puppet` with:

    ```
    apt-get install puppet
    ```

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