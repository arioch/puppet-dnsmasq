
# dnsmasq

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with dnsmasq](#setup)
    * [Beginning with dnsmasq](#beginning-with-dnsmasq)
3. [Usage - Configuration options and additional functionality](#usage)
	* [Adjust upstream resolving nameservers](#adjust-upstream-resolving-nameservers)
	* [PXE boot environment](#pxe-boot-environment)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

A fairly simple module to setup and manage Dnsmasq with support for:

- DNS resolving
- Internal DNS

... and more to come.

## Setup

### Beginning with dnsmasq

```
include ::dnsmasq
```

## Usage

### Adjust upstream resolving nameservers

```
class { '::dnsmasq':
  nameserver => ['1.1.1.1', '1.0.0.1'],
}
```

Using Hiera:

```
include ::dnsmasq
```

```
---
dnsmasq::nameserver:
  - 1.1.1.1
  - 1.0.0.1
```

### PXE boot environment

```
class { '::dnsmasq::pxe':
  dhcp_boot    => 'pxelinux.0',
  dhcp_gateway => '10.10.10.1',
  tftp_server  => '10.10.10.1',
  
  dhcp_range   => {
  	from    => '10.10.10.10',
  	to      => '10.10.10.20',
  	timeout => '15m',
  },
  
  dhcp_host    => {
  	'AA:BB:CC:DD:EE:FF' => '10.10.10.10',
  	'AA:BB:CC:DD:EE:00' => '10.10.10.20',
  },
}
```

## Limitations

Not every single feature supported by Dnsmasq is included in this module.  
Feel free to request features or to send pull requests.


## Development

When sending pull requests please make sure you do so from a feature/bugfix branch.  
Pull requests that don't include test coverage take me longer to merge as I need to write the missing tests myself.  
Any help is greatly appreciated.