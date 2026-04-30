SHELL := /bin/bash

CADDYFILE := ./caddy/Caddyfile
CADDY_APPS_DIR := ./caddy/apps

.PHONY: setup run-caddy reload-caddy validate-caddy start-services stop-services new-app help

help:
	@echo "Available targets:"
	@echo "  make setup            # Start Caddy for lvh.me-based local domains"
	@echo "  make run-caddy        # Run Caddy in the foreground"
	@echo "  make reload-caddy     # Reload Caddy config"
	@echo "  make validate-caddy   # Validate Caddy config"
	@echo "  make start-services   # Start caddy via Homebrew"
	@echo "  make stop-services    # Stop caddy via Homebrew"
	@echo "  make new-app NAME=foo PORT=3000  # Create app config (legacy helper)"

setup:
	./scripts/setup-macos.sh

run-caddy:
	caddy run --config $(CADDYFILE)

reload-caddy:
	caddy reload --config $(CADDYFILE)

validate-caddy:
	caddy validate --config $(CADDYFILE)

start-services:
	brew services start caddy

stop-services:
	brew services stop caddy

new-app:
	@test -n "$(NAME)" || (echo "NAME is required, e.g. make new-app NAME=flux PORT=3000" && exit 1)
	@test -n "$(PORT)" || (echo "PORT is required, e.g. make new-app NAME=flux PORT=3000" && exit 1)
	./scripts/new-app.sh --name "$(NAME)" --port "$(PORT)"
