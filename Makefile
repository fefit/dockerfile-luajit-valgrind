.PHONY: build

build: 
	docker build -t xiaofuzi123/luajit-valgrind:v2.1 -f Dockerfile.luajit .