class test {
	define tmpfile() {
		file { "/tmp/${name}":
			content	=>	"Hello, world\n",
		}
	}
	tmpfile { ['a', 'b', 'c']: }
}
