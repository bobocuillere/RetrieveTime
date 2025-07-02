# -------------------- Variables --------------------
# Path to the tfvars file
ENV ?= terraform.tfvars

# -------------------- Targets ----------------------
init:
	terraform init

plan:
	terraform plan

apply-ecr:
	terraform apply \
	  -target=module.ecr \
	  -var-file=$(ENV) \
	  -auto-approve

push-image:
	./ecr_push.sh

apply-all:
	terraform apply \
	  -auto-approve

deploy: init apply-ecr push-image apply-all
	@echo " Final Deployment complete"

.PHONY: init plan apply-ecr push-image apply-all first-deploy final-deploy
