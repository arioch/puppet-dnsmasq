# dnsmasq::service
#
class dnsmasq::service {
  service { $::dnsmasq::service_name:
    ensure    => $::dnsmasq::service_ensure,
    enable    => $::dnsmasq::service_enable,
    hasstatus => $::dnsmasq::service_hasstatus,
  }
}
