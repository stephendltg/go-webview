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
BINARY_NAME=test
AUTHOR=stephendltg

all: deps tool build-app

dev:
	$(GORUN) main.go

build-app:
	$(GOBUILD) -v -race .

build-linux:
	GOOS=linux $(GOBUILD) -v -o build/$(BINARY_NAME) .

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
