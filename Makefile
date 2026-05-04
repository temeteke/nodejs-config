PREFIX ?= $(HOME)

NPMRC := $(PREFIX)/.npmrc
LOCAL_BIN := $(PREFIX)/.local/bin

.PHONY: install uninstall check show

install:
	mkdir -p "$(LOCAL_BIN)"
	@if [ -e "$(NPMRC)" ] && ! cmp -s .npmrc "$(NPMRC)"; then \
		backup="$(NPMRC).bak.$$(date +%Y%m%d%H%M%S)"; \
		echo "Existing $(NPMRC) differs; backing up to $$backup"; \
		cp -a "$(NPMRC)" "$$backup"; \
	fi
	cp -a .npmrc "$(NPMRC)"
	@echo "Installed .npmrc to $(NPMRC)"
	@echo 'Make sure $$HOME/.local/bin is in PATH.'

uninstall:
	@if [ -f "$(NPMRC)" ] && cmp -s .npmrc "$(NPMRC)"; then \
		rm "$(NPMRC)"; \
		echo "Removed $(NPMRC)"; \
	else \
		echo "Not removing $(NPMRC) because it differs from repository .npmrc or does not exist."; \
	fi

check:
	npm config get prefix
	npm root -g
	@command -v npm >/dev/null && echo "npm: $$(command -v npm)"
	@echo "$$PATH" | tr ':' '\n' | grep -Fx "$$HOME/.local/bin" >/dev/null && echo "PATH contains $$HOME/.local/bin" || echo "WARNING: PATH does not contain $$HOME/.local/bin"

show:
	@cat .npmrc
