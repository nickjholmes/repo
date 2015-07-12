# Manage Nginx
class nginx {
  package { 'nginx': ensure => installed }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

  exec { 'reload nginx':
    command     => '/usr/sbin/service nginx reload',
    require     => Package['nginx'],
    refreshonly => true,
  }
}
