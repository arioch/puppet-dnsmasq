# dnsmasq::package
#
class dnsmasq::package {
  package { $::dnsmasq::package_name:
    ensure => $::dnsmasq::package_ensure,
  }
}
