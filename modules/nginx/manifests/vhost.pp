# Manage an Nginx virtual host
define nginx::vhost($domain='UNSET',$root='UNSET') {
  include nginx

  if $domain == 'UNSET' {
    $vhost_domain = $name
  } else {
    $vhost_domain = $domain
  }

  if $root == 'UNSET' {
    $vhost_root = "/var/www/${name}"
  } else {
    $vhost_root = $root
  }

  file { "/etc/nginx/sites-available/${vhost_domain}.conf":
    content => template('nginx/vhost.erb'),
    require => Package['nginx'],
  }

  file { "/etc/nginx/sites-enabled/${vhost_domain}.conf":
    ensure  => link,
    target  => "/etc/nginx/sites-available/${vhost_domain}.conf",
    require => File["/etc/nginx/sites-available/${vhost_domain}.conf"],
    notify  => Exec['reload nginx'],
  }
}
