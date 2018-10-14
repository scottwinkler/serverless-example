
# Go parameters
BINARY_NAME=main
all: clean deps build package
build: 
	cd server && GOOS=linux govendor install +local
	cd server && mv ~/go/bin/linux_amd64/server main
package:
	cd server && zip deployment.zip main
clean: 
	go clean
	rm -f server/$(BINARY_NAME)
	rm -f server/$(BINARY_NAME).zip
deps:
	go get -u github.com/kardianos/govendor
	cd server && govendor sync