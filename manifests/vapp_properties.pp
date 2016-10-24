network::if::static { "${vapp_interface}":
  ensure    => 'up',
  ipaddress => "${vapp_ip_address}",
  netmask   => "${vapp_netmask}",
  dns1      => "${vapp_dns_server_1}",
  dns2      => "${vapp_dns_server_2}",
  domain    => "${vapp_domain}",
}
class { 'network::global':
  hostname       => "${vapp_hostname}",
  gateway        => "${vapp_gateway}",
}
if $::vapp_dns_servers[0] != '' and $::vapp_dns_servers[1] != '' {
  class { 'resolv_conf':
    nameservers => [ "${vapp_dns_servers[0]}", "${vapp_dns_servers[1]}" ],
    domainname  => "${vapp_domain}",
  }
}
elsif $::vapp_dns_servers[0] != '' and $::vapp_dns_servers[1] == '' {
  class { 'resolv_conf':
    nameservers => [ "${vapp_dns_servers[0]}" ],
    domainname  => "${vapp_domain}",
  }
}  
elsif $::vapp_dns_servers[0] == '' and $::vapp_dns_servers[1] != '' {
  class { 'resolv_conf':
    nameservers => [ "${vapp_dns_servers[1]}" ],
    domainname  => "${vapp_domain}",
  }
}  
