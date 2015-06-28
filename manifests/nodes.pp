node 'njh67aws1' {
	include puppet
}
node 'njh67aws'{
#	#include memcached
#	#include test
#	include admin::ntp
	include admin::stages
#	if tagged('admin::ntp') {
#		notify { 'This node is running NTP': }
#	}
#	if tagged('admin') {
#		notify { 'This node includes at least one class from the admin module': }
#	}
#	tag('big_server')
#	if tagged('big_server') {
#		notify { 'Big server detected. Adding extra workload': }
#	}
}
