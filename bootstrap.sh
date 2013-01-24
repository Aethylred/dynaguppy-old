#!/bin/bash
#
# dynaguppy bootstrapping script

/usr/bin/apt-get install puppet git build-essential ruby-dev
cd /etc/puppet
/usr/bin/git init
/usr/bin/git remote add upstream git://github.com/Aethylred/dynaguppy.git
/usr/bin/git pull --force upstream master
/usr/bin/git checkout --force master
/usr/bin/gem install librarian-puppet-maestrodev
/usr/local/bin/
echo "Dynaguppy should now be ready to go."
