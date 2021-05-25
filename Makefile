BIN=bin
REL=release
BUILD_FLAGS="-s -w"
INSTALL_DIR="/usr/local/bin"

build:
	mkdir -p bin
	go build -o $(BIN)

compile:
	mkdir -p $(BIN)
	env CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o $(BIN)/cowin-cli -ldflags $(BUILD_FLAGS)
	env GOOS=windows GOARCH=amd64 go build -o $(BIN)/cowin-cli.exe -ldflags $(BUILD_FLAGS)

release: compile
	mkdir -p release
	zip -j9 $(REL)/cowin-cli_linux_64.zip "$(BIN)/cowin-cli" scripts/linux/*.sh
	zip -j9 $(REL)/cowin-cli_Windows_64.zip "$(BIN)/cowin-cli.exe" scripts/windows/*.bat

clean:
	rm -rf bin release
	go clean

run: 	build
	./$(BIN)/cowin-cli

install:	build
	cp $(BIN)/cowin-cli $(INSTALL_DIR)

all:	build
