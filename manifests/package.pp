# dnsmasq::package
#
# @summary A short summary of the purpose of this class
#
# @example
#   include dnsmasq::package
class dnsmasq::package {
  package { $::dnsmasq::package_name:
    ensure => $::dnsmasq::package_ensure,
  }
}
