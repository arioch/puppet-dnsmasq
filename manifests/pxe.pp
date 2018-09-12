# dnsmasq::pxe
#
# @summary This class provides support for PXE boot
#
# @example
#   include ::dnsmasq::pxe
#
class dnsmasq::pxe (
  Array[Hash[String, String]]   $dhcp_host,
  Boolean                       $tftp,
  Hash                          $dhcp_range,
  Stdlib::Absolutepath          $tftp_root,
  Stdlib::Ip::Address::Nosubnet $dhcp_gateway,
  Stdlib::Ip::Address::Nosubnet $dns_server,
  Stdlib::Ip::Address::Nosubnet $tftp_server,
  String                        $dhcp_boot,
  String                        $dhcp_ignore,
) {
  require ::dnsmasq

  file { '/etc/dnsmasq.d/pxe.conf':
    ensure  => file,
    group   => 0,
    mode    => '0644',
    owner   => 0,
    content => epp(
      'dnsmasq/pxe.conf.epp' #,
      # { 'hosts' => $::dnsmasq::hosts }
    ),
  }
}
