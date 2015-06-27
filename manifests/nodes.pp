node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
	#include memcached
	#include test
	include admin::ntp
}
