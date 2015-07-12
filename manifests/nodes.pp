node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
#	include apache
	apache::vhost { 'cat-pictures.com': }
}
