class user::virtual {
#	@user { 'nirmala': ensure => present }
#	@user { 'sarah': ensure => present }
#	@user { 'jeff': ensure => present }
#	@user { 'ayomide': ensure => present }
	define ssh_user($key) {
		user { $name:
		ensure	=>	present,
		managehome	=>	true,
	}

	file { "/home/${name}/.ssh":
		ensure	=>	directory,
		mode	=>	'0700',
		owner	=>	$name,
	}

	ssh_authorized_key { "${name}_key":
		key	=>	$key,
		type	=>	'ssh-rsa',
		user	=> 	$name,
		require	=>	File["/home/${name}/.ssh"],
	}
	}
	@ssh_user { 'aliza':
		key	=>	'AAAAB3NzaClyc2EAAAABIwAAAIEA3ATqENg+GWACa2BzeqTdGnJhNoBer8x6pfWkzNzeM8Zx7/2Tf2pl7kHdbsiTXEUawqzXZQtzt/j3Oya+PZjcRpWNRzprSmd2UxEEPTqDw9LqY5S2B8og/NyzWaIYPsKoatcgC7VgYHplcTbzEhGu8BsoEVBGYu3IRy5RkAcZik=',
	}
}
