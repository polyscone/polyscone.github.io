.ONESHELL:
.DEFAULT_GOAL := build
.SHELLFLAGS += -e
MAKEFLAGS += --no-print-directory

.PHONY: build
build:
ifeq ($(OS),Windows_NT)
	@rm -rf docs
else
	@cmd //C del //Q //F docs 2>nul
endif

	hugo

ifeq ($(OS),Windows_NT)
	@cmd //C copy CNAME docs
else
	@cp ./CNAME ./docs/CNAME
endif
