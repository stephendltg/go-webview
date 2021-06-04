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
BINARY_NAME=epyo-manager
PKG_LINUX=build/epyo-manager-linux
PKG_RASP=build/epyo-manager-rasp
VERSION := $(shell node -p "require('./package.json').version")
AUTHOR=stephendltg

all: deps tool build-app

dev:
	$(GORUN) main.go

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
	echo "Description: Application skeleton webview" >> $(PKG_LINUX)/DEBIAN/control
	echo "Homepage: https://github.com/stephendltg/skeleton-go-webview" >> $(PKG_LINUX)/DEBIAN/control
	GOOS=linux $(GOBUILD) -v -o $(PKG_LINUX)/usr/bin/$(BINARY_NAME) .
	sudo dpkg-deb --build $(PKG_LINUX)
	rm -r $(PKG_LINUX)/*
	rmdir $(PKG_LINUX)

build-deb-rasp:
	mkdir -p $(PKG_RASP)/DEBIAN
	mkdir -p $(PKG_RASP)/usr/bin/
	echo "Package: $(BINARY_NAME)" > $(PKG_RASP)/DEBIAN/control
	echo "Version: $(VERSION)" >> $(PKG_RASP)/DEBIAN/control
	echo "Section: custom" >> $(PKG_RASP)/DEBIAN/control
	echo "Architecture: all" >> $(PKG_RASP)/DEBIAN/control
	echo "Essential: no" >> $(PKG_RASP)/DEBIAN/control
	echo "Depends: libwebkit2gtk-4.0-dev" >> $(PKG_RASP)/DEBIAN/control
	echo "Maintainer: $(AUTHOR)" >> $(PKG_RASP)/DEBIAN/control
	echo "Description: Application skeleton webview" >> $(PKG_RASP)/DEBIAN/control
	echo "Homepage: https://github.com/stephendltg/skeleton-go-webview" >> $(PKG_RASP)/DEBIAN/control
	GOOS=linux $(GOBUILD) -v -o $(PKG_RASP)/usr/bin/$(BINARY_NAME) .
	GOOS=linux GOARCH=arm GOARM=5 $(GOBUILD) -v -o $(PKG_RASP)/usr/bin/$(BINARY_NAME) .
	sudo dpkg-deb --build $(PKG_RASP)
	rm -r $(PKG_RASP)/*
	rmdir $(PKG_RASP)

build-linux:
	GOOS=linux $(GOBUILD) -v -o $(BINARY_NAME)/usr/bin/$(BINARY_NAME) .

build-rasp:
	GOOS=linux GOARCH=arm GOARM=5 $(GOBUILD) -v -o build/$(BINARY_NAME)-rasp .

build-darwin:
	mkdir -p build/$(BINARY_NAME).app/Contents/Macos
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -v -o build/$(BINARY_NAME).app/Contents/MacOS/$(BINARY_NAME) .

build-win:
	GIN_MODE=release GOOS=windows GOARCH=amd64 $(GOBUILD) -ldflags="-H windowsgui" -v -o build/$(BINARY_NAME)-win-amd64.exe .

tool:
	$(GOVET) ./...; true
	$(GOFMT) -w .

clean:
	go clean -i .
	rm -f $(BINARY_NAME)
	rm -r build/*

deps:
	go mod vendor
	# go mod tidy
	go mod verify

help:
	@echo "make: compile packages and dependencies"
	@echo "make tool: run specified go tool"
	@echo "make clean: remove object files and cached files"
	@echo "make deps: get the deployment tools"
