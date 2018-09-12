# dnsmasq::pxe
#
# @summary This class provides support for PXE boot
#
# @example
#   include ::dnsmasq::pxe
#
class dnsmasq::pxe (
  Boolean                       $tftp,
  Stdlib::Absolutepath          $tftp_root,
  Stdlib::Ip::Address::Nosubnet $dhcp_gateway,
  Stdlib::Ip::Address::Nosubnet $dns_server,
  Stdlib::Ip::Address::Nosubnet $tftp_server,
  String                        $dhcp_boot,
  String                        $dhcp_ignore,

  Array[Hash[Stdlib::MAC, Stdlib::Ip::Address::Nosubnet]]                  $dhcp_host,
  Hash[String, Variant[Stdlib::Ip::Address::Nosubnet,Pattern[/\d+(s|m)/]]] $dhcp_range,
) {
  require ::dnsmasq

  file { '/etc/dnsmasq.d/pxe.conf':
    ensure  => file,
    group   => 0,
    mode    => '0644',
    owner   => 0,
    content => epp('dnsmasq/pxe.conf.epp'),
  }
}
