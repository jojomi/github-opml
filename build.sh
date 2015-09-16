#!/usr/bin/env sh
#
# For using UPX on linux, goupx (https://github.com/pwaller/goupx) needs to be
# available in $PATH.
# install goupx:
# GOPATH=${HOME}/.local go get github.com/pwaller/goupx
# sudo ln -s "${HOME}/.local/bin/goupx" "/usr/local/bin/"

UPX_ENABLE=yes
UPX_PARAMS=-9 # --ultra-brute

BIN_NAME=${PWD##*/} # or just give a plain string here
BIN_DIR="bin"
BIN_LINUX=$BIN_DIR/linux64/$BIN_NAME
BIN_MAC=$BIN_DIR/macosx/$BIN_NAME
BIN_WIN=$BIN_DIR/win/$BIN_NAME.exe


# run gofmt
gofmt -w .


# prepare building
mkdir --parents "$BIN_DIR"


# building for all target platforms
echo "Building for linux64..."
GOOS=linux GOARCH=amd64 go build -ldflags "-w -s" -o "$BIN_LINUX" ./...
if [[ $? -ne 0 ]]; then
    exit 1
fi
echo "Done."

echo "Building for macosx..."
GOOS=darwin GOARCH=386 go build -ldflags "-w -s" -o "$BIN_MAC" ./...
if [[ $? -ne 0 ]]; then
    exit 1
fi
echo "Done."

echo "Building for windows..."
GOOS=windows GOARCH=386 go build -ldflags "-w -s" -o "$BIN_WIN" ./...
if [[ $? -ne 0 ]]; then
    exit 1
fi
echo "Done."


# minimize binaries using upx (not necessary, might increase number of "security"
# software false positives)
if [ $UPX_ENABLE = "yes" ]; then
  if hash upx 2>/dev/null; then
    upx $UPX_PARAMS "$BIN_MAC"
    upx $UPX_PARAMS "$BIN_WIN"

    GOUPX_BIN=$(which goupx)
    if [ -f $GOUPX_BIN ]; then
      $GOUPX_BIN "$BIN_LINUX" --no-upx
      upx $UPX_PARAMS "$BIN_LINUX"
    fi
  fi
fi