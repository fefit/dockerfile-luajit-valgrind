.PHONY: build test-leak test-no-leak

PWD=$(shell pwd)

build: 
	docker build -t xiaofuzi123/luajit-valgrind:v2.1 -f Dockerfile.luajit .

test-leak:
	docker run -it --rm -v $(PWD)/examples/:/lua/ -w /lua \
	-e LUA_PATH="/lua/?.lua;;;" \
	xiaofuzi123/luajit-valgrind:v2.1 \
	--cfile /lua/demo.c --tool=memcheck luajit -e "require('demo').test_leak()"

test-no-leak:
	docker run -it --rm -v $(PWD)/examples/:/lua/ -w /lua \
	-e LUA_PATH="/lua/?.lua;;;" \
	xiaofuzi123/luajit-valgrind:v2.1 \
	--cfile /lua/demo.c --tool=memcheck luajit -e "require('demo').test_no_leak()"