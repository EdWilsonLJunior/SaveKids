# Makefile — ZodiakiOS
# Phase 6 quality gates centralizados.

PROJECT := ZodiakiOS.xcodeproj
SCHEME := ZodiakiOS
DESTINATION := platform=iOS Simulator,name=iPhone 17
SWIFTLINT_CONFIG := .swiftlint.yml

.PHONY: help lint fix build test audit docs install-hooks clean all

help: ## Mostra este help
	@echo "Targets disponíveis:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

lint: ## SwiftLint check (strict)
	swiftlint lint --strict --config $(SWIFTLINT_CONFIG)

fix: ## SwiftLint auto-fix
	swiftlint lint --fix --config $(SWIFTLINT_CONFIG)
	@echo "✅ Auto-fix complete. Rode 'make lint' para conferir violações restantes."

build: ## Build Debug iPhone 17
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) -configuration Debug -destination '$(DESTINATION)' build | xcpretty || \
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) -configuration Debug -destination '$(DESTINATION)' build

test: ## Run all unit + UI tests no iPhone 17
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) -destination '$(DESTINATION)' -enableCodeCoverage YES test | xcpretty || \
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) -destination '$(DESTINATION)' -enableCodeCoverage YES test

audit: ## Roda audits Python (dark mode, etc)
	python3 scripts/audit_dark_mode.py --strict

docs: ## Extrai PDFs Zodiak para texto diffável
	./scripts/extract_zodiak_pdfs.sh

install-hooks: ## Instala git hooks (.githooks/pre-commit)
	git config core.hooksPath .githooks
	chmod +x .githooks/pre-commit 2>/dev/null || true
	@echo "✅ Hooks instalados em .githooks/"

clean: ## Limpa derived data e build outputs
	xcodebuild -project $(PROJECT) -scheme $(SCHEME) clean
	rm -rf ~/Library/Developer/Xcode/DerivedData/ZodiakiOS-*

icons: ## Extrai SVGs dos .ts da Kamila e importa para xcassets. Uso: make icons TS_DIR=~/path/to/ts-files
	@if [ -z "$(TS_DIR)" ]; then echo "❌ Defina TS_DIR. Exemplo: make icons TS_DIR=~/Downloads/zodiak-icons"; exit 1; fi
	python3 scripts/extract_icons_from_ts.py "$(TS_DIR)"
	./scripts/import-visual-assets.sh

all: lint build test audit ## Rota completa de CI local
