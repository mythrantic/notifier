.PHONY: help dev install

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[0;33m
NC := \033[0m # No Color

# Local development URLs (override production URLs in .env files)
VIS_DOMAIN := http://localhost:3000

help: ## Show this help message
	@echo "$(BLUE)MCP Development Commands$(NC)"
	@echo "Local VIS domain: $(VIS_DOMAIN)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "$(GREEN)%-20s$(NC) %s\n", $$1, $$2}'

# Development commands
dev: ## Start all services in development mode (requires tmux or multiple terminals)
	@echo "$(YELLOW)Starting all services...$(NC)"
	@$(MAKE) -j1 dev-notifier

dev-notifier: ## Start backend development server (port 8082)
	@echo "$(BLUE)Starting notifier on http://localhost:8082$(NC)"
	@uv run python src/notifier/notify.py

install: ## Install all (uv)
	@echo "$(BLUE)Installing dependencies...$(NC)"
	@$(MAKE) -j1 install-notifier
install-notifier: ## Install notifier dependencies (uv)
	@echo "$(BLUE)Installing notifier dependencies...$(NC)"
	@uv sync

clean: ## Clean all build artifacts and dependencies
	@echo "$(BLUE)Cleaning all build artifacts and dependencies...$(NC)"
	@$(MAKE) -j1 clean-notifier
clean-notifier: ## Clean notifier build artifacts and dependencies
	@echo "$(BLUE)Cleaning notifier...$(NC)"
	@rm -rf .venv __pycache__
	
# Default target
.DEFAULT_GOAL := help