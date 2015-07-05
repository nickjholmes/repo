node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
#	include admin::rsyncdconf
#
#	file { '/etc/rsyncd.d/myapp.conf':
#		ensure	=> present,
#		source 	=> 'puppet:///modules/admin/myapp.rsync',
#		require	=> File['/etc/rsyncd.d'],
#		notify	=> Exec['update-rsyncd.conf'],
#	}
	$mysql_password = 'secret'
	file { '/usr/local/bin/backup-mysql':
		content	=>	template('admin/backup-mysql.sh.erb'),
		mode	=>	'0755',
	}
}
