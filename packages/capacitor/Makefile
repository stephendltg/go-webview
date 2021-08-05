#!make
PROJECT=webview
VERSION=v14.16.1
NVM=v0.38.0


install: 
	@echo "Installing project ${PROJECT}..."
	. ${NVM_DIR}/nvm.sh && nvm install ${VERSION} && nvm use ${VERSION}
	npm install

clean:
	@echo "Clean project ${PROJECT}..."
	npm run clean
	rm -rf ./node_modules

nvm:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM}/install.sh | bash


help: 
	@echo "install: Install ${PROJECT}"
	@echo "stop-production: Stop production ${PROJECT}"
	@echo "clean: Clean ${PROJECT}"
	@echo "nvm: NVM install${PROJECT}"