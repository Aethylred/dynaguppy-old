# This would be located in my_fw/manifests/post.pp:
class dynaguppy::firewall::post {
  firewall { '999 drop all':
    proto   => 'all',
    action  => 'drop',
    before  => undef,
  }
}