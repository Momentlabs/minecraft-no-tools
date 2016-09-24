
repo := minecraft-no-tools

# AWS Config
aws_repo := 033441544097.dkr.ecr.us-east-1.amazonaws.com
profile := momentlabs
region := us-east-1

# GEt an auth-token to enable docker to use the AWS Repository.
login := $(shell aws --profile $(profile) --region $(region) --output text ecr get-login)
token := $(shell echo $(login)| awk '{print $$6}')

help:
	@echo local \# builds the dockerfile localy to $(rep)
	@echo deploy-to-repo \# builds and pushes the file the AWS repo.

local:
	@echo building local image: $(repo)
	docker build -t $(repo) .

deploy-to-repo: local
	@echo Bulding and pusing repository repository: $(repo)
	docker login -u AWS -p $(token) https://$(aws_repo)
	docker tag $(repo):latest $(aws_repo)/$(repo):latest
	docker push $(aws_repo)/$(repo):latest