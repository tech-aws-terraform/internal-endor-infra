.DEFAULT_GOAL := help

#ENVIRONMENT := dev/eu-central-1

## Terragrunt/Terraform
.PHONY: init validate plan apply destroy

init: ## Init Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all init --terragrunt-non-interactive

init-common: ## Init Terragrunt/Terraform resources
	cd ./live/endor-common-$(ENVIRONMENT) && terragrunt run-all init --terragrunt-non-interactive

validate: init ## Validate Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all validate --terragrunt-non-interactive

validate-common: init-common ## Validate Terragrunt/Terraform resources
	cd ./live/endor-common-$(ENVIRONMENT) && terragrunt run-all validate --terragrunt-non-interactive

plan: validate ## Plan Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all plan --terragrunt-non-interactive

plan-common: validate-common ## Plan Terragrunt/Terraform resources
	cd ./live/endor-common-$(ENVIRONMENT) && terragrunt run-all plan --terragrunt-non-interactive

apply: plan ## Apply Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all apply --terragrunt-non-interactive

apply-common: init-common ## Apply Terragrunt/Terraform resources
	cd ./live/endor-common-$(ENVIRONMENT) && terragrunt run-all apply --terragrunt-non-interactive

apply-cicd: init ## Apply Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all apply --terragrunt-non-interactive

destroy: validate ## Destroy Terragrunt/Terraform resources
	cd ./live/endor-$(ENVIRONMENT) && terragrunt run-all destroy --terragrunt-non-interactive

destroy-common: validate-common ## Destroy Terragrunt/Terraform resources
	cd ./live/endor-common-$(ENVIRONMENT) && terragrunt run-all destroy --terragrunt-non-interactive

## Linter
.PHONY: lint-all
lint-all: init ## Lint all files
	pre-commit run --all-files

## Convenient commands
.PHONY: help

help: ## Print this help
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-15s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
