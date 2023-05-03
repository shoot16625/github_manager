LICENSE ?= MIT

.DEFAULT_GOAL := help

.PHONY: help
help: ## here is description ## here is example code
	@echo "Example operations by makefile."
	@echo ""
	@echo "Usage: make SUB_COMMAND argument_name=argument_value"
	@echo ""
	@echo "Command list:"
	@echo ""
	@printf "\033[36m%-30s\033[0m %-50s %s\n" "[Sub command]" "[Description]" "[Example]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'

.PHONY: init
init: ## install libraries  ## make init
	brew install gh

.PHONY: auth
login: ## login github ## make login
	gh auth login

.PHONY: exec_query
exec_query: ## exec shellscript ## make exec_query REPO_NAME=repository_name
	sh repository/$(REPO_NAME)/main.sh
