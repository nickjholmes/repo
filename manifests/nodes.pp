node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
	include admin::percona_repo

	package { 'percona-server-server-5.5':
		ensure	=>	installed,
		require	=>	Class['admin::percona_repo'],
	}
}
