class dynaguppy::firewall {
  include dynaguppy::firewall::persist
  class {'firewall':}
}