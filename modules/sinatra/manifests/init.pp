# Install and create sinatra application

class sinatra {

package { 'nginx':
	ensure => installed,
	}

user { 'nginx':
	ensure => present,
	require	=> [ Package['nginx'] ],
}
	
service { 'nginx':
	ensure	=> running,
	require	=> [ User['nginx'] ],
}

package { 'bundler':
	ensure => installed,
	require=> [ Service['nginx'] ],
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
	
# perform bundle install
exec { 'bundle install':
	command=> '/usr/bin/bundle install',
	cwd=> '/opt/code/nginx-unicorn-sinatra',
	require	=> [ Vcsrepo['/opt/code/simple-sinatra-app'] ],
	}


# create directories
file { [ '/opt/code/nginx-unicorn-sinatra/var/', '/opt/code/nginx-unicorn-sinatra/var/run', '/opt/code/nginx-unicorn-sinatra/var/log', '/var/www' ]:
    	ensure => directory,
		mode =>	775,
		require	=> [ Exec['bundle install'] ],
	}

# preferred symlink syntax
file { '/var/www/nginx-unicorn-sinatra':
	ensure => link,
	target => '/opt/code/nginx-unicorn-sinatra',
	require	=> [ File['/opt/code/nginx-unicorn-sinatra/var/', '/opt/code/nginx-unicorn-sinatra/var/run', '/opt/code/nginx-unicorn-sinatra/var/log', '/var/www'] ],
	}	

	
# archive /etc/nginx/nginx.conf
exec { 'copy /etc/nginx/nginx.conf':
	command=> '/bin/cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig',
	require	=> [ File['/var/www/nginx-unicorn-sinatra'] ],
	}

# copy in new nginx.conf
file { '/etc/nginx/nginx.conf':
	ensure => present,
	source => '/opt/code/nginx-unicorn-sinatra/config/nginx.conf',
	require	=> [ Exec['copy /etc/nginx/nginx.conf'] ],
	}

# archive /opt/code/nginx-unicorn-sinatra/config.ru
exec { 'copy /opt/code/nginx-unicorn-sinatra/config.ru':
	command=> '/opt/code/nginx-unicorn-sinatra/config.ru /opt/code/nginx-unicorn-sinatra/config.ru.orig',
	require	=> [ File['/etc/nginx/nginx.conf'] ],
	}
	
# copy in new /opt/code/nginx-unicorn-sinatra/config.ru
file { '/opt/code/nginx-unicorn-sinatra/config.ru':
        ensure => present,
        source => '/opt/code/simple-sinatra-app/config.ru',
		require	=> [ Exec['copy /opt/code/nginx-unicorn-sinatra/config.ru'] ],
        }

file { '/opt/code/nginx-unicorn-sinatra/helloworld.rb':
        ensure => present,
        source => '/opt/code/simple-sinatra-app/helloworld.rb',
		require	=> [ File['/opt/code/nginx-unicorn-sinatra/config.ru'] ],
        }

}
