# Install and create sinatra application

class sinatra {

package { 'nginx':
	ensure => installed,
	}

service { 'nginx':
	ensure	=> running,
	require	=> [ Package['nginx'] ],
}
	
#package { 'git':
#	ensure => installed,
#	require=> [ Service['nginx'] ],
#	}

#service { 'git':
#	ensure	=> running,
#	require	=> [ Package['git'] ],
#}

package { 'bundler':
	ensure => installed,
	require=> [ Package['git'] ],
	install_options => [ '-y' ],
	}

vcsrepo { '/opt/code/nginx-unicorn-sinatra':
	ensure	=> latest,
	owner	=> root,
	group	=> root,
	provider=> git,
	require	=> [ Package['bundler'] ],
	source	=> 'git://github.com/p8952/nginx-unicorn-sinatra.git',
	revision=> 'master',
	}

vcsrepo { '/opt/code/simple-sinatra-app':
	ensure	=> latest,
	owner	=> root,
	group	=> root,
	provider=> git,
	require	=> [ Vcsrepo['/opt/code/nginx-unicorn-sinatra'] ],
	source	=> 'git://github.com/tnh/simple-sinatra-app.git',
	revision=> 'master',
	}

# preferred symlink syntax
file { '/opt/code/nginx-unicorn-sinatra':
	ensure => link,
	target => '/var/www/nginx-unicorn-sinatra',
	require	=> [ Vcsrepo['/opt/code/simple-sinatra-app'] ],
	}
	
exec { 'bundle install':
	command=> '/usr/bin/bundle install',
	cwd=> '/opt/code/nginx-unicorn-sinatra',
	require	=> [ File['/opt/code/nginx-unicorn-sinatra'] ],
	}

	

# create directories
file { [ '/var/run', '/var/log' ]:
    	ensure => directory,
		require	=> [ Exec['bundle install'] ],
	}

file { '/etc/nginx/nginx.conf':
	ensure => present,
	source => '/opt/code/nginx-unicorn-sinatra/config/nginx.conf',
	require	=> [ File['/var/log', '/var/log'] ],
	}

file { '/opt/code/nginx-unicorn-sinatra/config.ru':
        ensure => present,
        source => '/opt/code/simple-sinatra/config.ru',
	require	=> [ File['/etc/nginx/nginx.conf'] ],
        }

file { '/opt/code/nginx-unicorn-sinatra/helloworld.rb':
        ensure => present,
        source => '/opt/code/simple-sinatra/helloworld.rb',
	require	=> [ File['/opt/code/nginx-unicorn-sinatra/config.ru'] ],
        }

}
