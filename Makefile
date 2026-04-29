SHELL := /bin/bash

CADDYFILE := ./caddy/Caddyfile
CADDY_APPS_DIR := ./caddy/apps

.PHONY: setup run-caddy reload-caddy validate-caddy start-services stop-services restart-dnsmasq new-app help

help:
	@echo "Available targets:"
	@echo "  make setup            # Configure dnsmasq + macOS resolver"
	@echo "  make run-caddy        # Run Caddy in the foreground"
	@echo "  make reload-caddy     # Reload Caddy config"
	@echo "  make validate-caddy   # Validate Caddy config"
	@echo "  make start-services   # Start dnsmasq and caddy via Homebrew"
	@echo "  make stop-services    # Stop dnsmasq and caddy via Homebrew"
	@echo "  make restart-dnsmasq  # Restart dnsmasq via Homebrew"
	@echo "  make new-app NAME=foo PORT=3000  # Create app config"

setup:
	./scripts/setup-macos.sh

run-caddy:
	caddy run --config $(CADDYFILE)

reload-caddy:
	caddy reload --config $(CADDYFILE)

validate-caddy:
	caddy validate --config $(CADDYFILE)

start-services:
	brew services start dnsmasq
	brew services start caddy

stop-services:
	brew services stop dnsmasq
	brew services stop caddy

restart-dnsmasq:
	brew services restart dnsmasq

new-app:
	@test -n "$(NAME)" || (echo "NAME is required, e.g. make new-app NAME=flux PORT=3000" && exit 1)
	@test -n "$(PORT)" || (echo "PORT is required, e.g. make new-app NAME=flux PORT=3000" && exit 1)
	mkdir -p $(CADDY_APPS_DIR)
	printf "%s.test {\n\treverse_proxy localhost:%s\n}\n" "$(NAME)" "$(PORT)" > "$(CADDY_APPS_DIR)/$(NAME).caddy"
	@echo "Created $(CADDY_APPS_DIR)/$(NAME).caddy"
	@echo "Reload Caddy with: make reload-caddy"
