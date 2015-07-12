node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
#	include admin::percona_repo
#
#	package { 'percona-server-server-5.5':
#		ensure	=>	installed,
#		require	=>	Class['admin::percona_repo'],
#	}
#
#exec { 'install-httperf':
#  cwd     => '/root',
#  command => '/usr/bin/wget https://httperf.googlecode.com/files/httperf-0.9.0.tar.gz && /bin/tar xvzf httperf-0.9.0.tar.gz && cd httperf-0.9.0 && ./configure && make all && make install',
#  creates => '/usr/local/bin/httperf',
#  timeout => 0,
#}
#$app_version = '1.2.10'
#$min_version = '1.2.2'
#
#if versioncmp($app_version, $min_version) >= 0 {
#  notify { 'Version OK': }
#} else {
#  notify { 'Upgrade needed': }
#}
#	include app::facesquare
#	include app::flipr
	include user::virtual
	include user::sysadmins
#	include user::developers
}
