CWD := $(shell pwd)

TARGETS := build run

.PHONY: all $(TARGETS)

all:
	@echo "Targets: build run"

build:
	@docker build --tag expedition . 2>&1 | tee build.log

run:
	@docker run \
		--interactive \
		--rm \
		--tty \
		--cap-add SYSLOG \
		--publish 443:443 \
		--publish 4050:4050 \
		expedition /bin/bash
