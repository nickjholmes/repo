node 'njh67aws1' {
#	include puppet
	include sinatra
}
node 'njh67aws'{
#	include apache
#	apache::vhost { 'cat-pictures.com': }
#	nginx::vhost { 'cat-pictures.com': }
	include sinatra
}
