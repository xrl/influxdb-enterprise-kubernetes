.PHONY: build validate push

REPO_NAME := "telegraf"
REPO := $(shell aws ecr describe-repositories | jq '.repositories[].repositoryUri | select( . | contains(${REPO_NAME}))')
TAG := "influxdb-iops"

build: Dockerfile telegraf.conf
	docker build -t $(REPO):$(TAG) .

login:
	aws ecr get-login --no-include-email # | bash

validate: build
	docker run --rm -it $(REPO):$(TAG) telegraf --test

push: build
	docker push $(REPO):$(TAG)