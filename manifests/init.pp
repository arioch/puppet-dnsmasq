# dnsmasq
#
# @summary Setup and manage dnsmasq.
#
# @example
#   include dnsmasq
#
# @param conf_dir
# @param nameserver
# @param package_ensure
# @param package_name
# @param service_enable
# @param service_ensure
# @param service_hasstatus
# @param service_name
#
class dnsmasq (
  Boolean                    $service_enable,
  Boolean                    $service_hasstatus,
  Array[Hash[String, Array]] $hosts,
  Stdlib::Absolutepath       $conf_dir,
  Stdlib::Ensure::Service    $service_ensure,
  String                     $package_ensure,
  String                     $package_name,
  String                     $service_name,

  Variant[
    Stdlib::Ip::Address::Nosubnet,
    Array[Stdlib::Ip::Address::Nosubnet]
  ] $nameserver = [ '1.1.1.1', '1.0.0.1' ], # TODO: Hiera
) {
  class { '::dnsmasq::package': }
  -> class { '::dnsmasq::config': }
  ~> class { '::dnsmasq::service': }
  -> Class['::dnsmasq']
}
