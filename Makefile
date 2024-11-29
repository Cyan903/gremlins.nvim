TESTS_INIT=lua/tests/minimal_init.lua
TESTS_DIR=lua/tests/
SOURCE_DIR=lua/gremlins

.PHONY: test debug

test:
	@nvim \
		--headless \
		--noplugin \
		-u ${TESTS_INIT} \
		-c "PlenaryBustedDirectory ${TESTS_DIR} { minimal_init = '${TESTS_INIT}' }"

debug:
	@nvim \
		-c "set rtp+=./"

lint:
	@luacheck ${SOURCE_DIR}

format:
	@stylua ${SOURCE_DIR}
