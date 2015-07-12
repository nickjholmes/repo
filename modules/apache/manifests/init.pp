# Manage Apache
class apache {
  package { 'apache2-mpm-prefork': ensure => installed }

  service { 'apache2':
    ensure  => running,
    enable  => true,
    require => Package['apache2-mpm-prefork'],
  }
}
