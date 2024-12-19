SOURCE_DIR=lua/gremlins

.PHONY: debug lint format

debug:
	@nvim \
		-c "set rtp+=./"

lint:
	@luacheck ${SOURCE_DIR}

format:
	@stylua ${SOURCE_DIR}
