# dnsmasq::config
#
# @summary A short summary of the purpose of this class
#
# @example
#   include dnsmasq::config
class dnsmasq::config {
  file { '/etc/dnsmasq.d':
    ensure => directory,
    group  => 0,
    mode   => '0755',
    owner  => 0,
  }

  file { '/etc/dnsmasq.conf':
    ensure => file,
    group  => 0,
    mode   => '0644',
    owner  => 0,
  }

  file { '/etc/dnsmasq.resolv':
    ensure  => file,
    group   => 0,
    mode    => '0644',
    owner   => 0,
    content => epp('dnsmasq/dnsmasq.resolv.epp'),
  }

  $hosts_ensure = $::dnsmasq::hosts ? {
    []      => 'absent',
    default => 'file',
  }

  file { '/etc/dnsmasq.d/hosts.conf':
    ensure  => $hosts_ensure,
    group   => 0,
    mode    => '0644',
    owner   => 0,
    source  => 'puppet:///modules/dnsmasq/hosts.conf',
  }

  file { '/etc/dnsmasq.hosts':
    ensure  => $hosts_ensure,
    group   => 0,
    mode    => '0644',
    owner   => 0,
    content => epp(
      'dnsmasq/dnsmasq.hosts.epp',
      { 'hosts' => $::dnsmasq::hosts }
    ),
  }
}
