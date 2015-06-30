node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
	include admin::rsyncdconf

	file { '/etc/rsyncd.d/myapp.conf':
		ensure	=> present,
		source 	=> 'puppet:///modiles/admin/files/myapp.rsync',
		require	=> File['/etc/rsyncd.d'],
		notify	=> Exec['update-rsyncd.conf'],
	}
}
