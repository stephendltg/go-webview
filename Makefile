# Go parameters
GOCMD=go
GOBUILD=$(GOCMD) build
GORUN=$(GOCMD) run
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
GOVET=$(GOCMD) vet
GOFMT=gofmt
GOLINT=golint
BINARY_NAME=$(shell node -p "require('./package.json').name")
PKG_LINUX=bin/${BINARY_NAME}-linux
VERSION := $(shell node -p "require('./package.json').version")
DESCRIPTION := $(shell node -p "require('./package.json').description")
HOMEPAGE := $(shell node -p "require('./package.json').homepage")
AUTHOR=stephendltg
NODE=v14.16.1
NVM=v0.38.0

all: deps tool build-app

pre-install: 
	@echo "Installing project ${BINARY_NAME}..."
	. ${NVM_DIR}/nvm.sh && nvm install ${NODE} && nvm use ${NODE}
	npm install
	curl -fsSL https://deno.land/x/install/install.sh | sh
	deno upgrade --version 1.12.2

dev:
	$(GORUN) main.go -debug -title="my app" -dir="${PWD}/static"

build-app:
	$(GOBUILD) -v -race .

build-deb:
	mkdir -p $(PKG_LINUX)/DEBIAN
	mkdir -p $(PKG_LINUX)/usr/bin/
	echo "Package: $(BINARY_NAME)" > $(PKG_LINUX)/DEBIAN/control
	echo "Version: $(VERSION)" >> $(PKG_LINUX)/DEBIAN/control
	echo "Section: custom" >> $(PKG_LINUX)/DEBIAN/control
	echo "Architecture: all" >> $(PKG_LINUX)/DEBIAN/control
	echo "Essential: no" >> $(PKG_LINUX)/DEBIAN/control
	echo "Depends: libwebkit2gtk-4.0-dev" >> $(PKG_LINUX)/DEBIAN/control
	echo "Maintainer: $(AUTHOR)" >> $(PKG_LINUX)/DEBIAN/control
	echo "Description: $(DESCRIPTION)" >> $(PKG_LINUX)/DEBIAN/control
	echo "Homepage: ${HOMEPAGE}" >> $(PKG_LINUX)/DEBIAN/control
	GOOS=linux $(GOBUILD) -v -o $(PKG_LINUX)/usr/bin/$(BINARY_NAME) .
	sudo dpkg-deb --build $(PKG_LINUX)
	rm -r $(PKG_LINUX)/*
	rmdir $(PKG_LINUX)

build-linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -v -o bin/$(BINARY_NAME)-linux-amd64 .

build-darwin:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -v -o bin/$(BINARY_NAME)-darwin-amd64 .

build-rasp:
	GOOS=linux GOARCH=arm GOARM=5 $(GOBUILD) -v -o bin/$(BINARY_NAME)-rasp .

build-darwin-pkg:
	mkdir -p build/$(BINARY_NAME).app/Contents/Macos
	mkdir -p build/$(BINARY_NAME).app/Contents/Resources
	cp assets/info.plist build/$(BINARY_NAME).app/Contents/Resources/info.plist
	cp assets/icon.icns build/$(BINARY_NAME).app/Contents/Resources
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -v -o bin/$(BINARY_NAME).app/Contents/MacOS/$(BINARY_NAME) .

build-win:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -ldflags="-H windowsgui" -v -o bin/$(BINARY_NAME)-win-amd64.exe .

tool:
	$(GOVET) ./...; true
	$(GOFMT) -w .

clean:
	go clean -i .
	rm -f $(BINARY_NAME)
	rm -r bin/*

deps:
	go mod vendor
	# go mod tidy
	go mod verify

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM}/install.sh | bash

help:
	@echo "make: compile packages and dependencies"
	@echo "make tool: run specified go tool"
	@echo "make clean: remove object files and cached files"
	@echo "make nvm: insall nvm"
	@echo "make pre-install: Pre install nodejs"
	@echo "make deps: get the deployment tools"
