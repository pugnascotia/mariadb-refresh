all:
	test -e mantra || curl -o mantra -L https://github.com/pugnascotia/mantra/releases/download/0.0.1/mantra
	chmod +x mantra
	docker build -t mariadb-refresh .
