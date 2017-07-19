# JS_FILES = $(shell find src -type f | grep .js | tr '\n' ' ' | sed 's/src\//build\//g')
NODEPATH = $(shell npm bin)

test: eslint
eslint:
	$(NODEPATH)/eslint $(shell find src -type f | grep .js | tr '\n' ' ')
