#!/bin/bash

readonly   OS_L="linux darwin windows"
readonly ARCH_L="arm64 amd64"

# REF: Supported target architectures will be similar to:
# $ go tool dist list
# > aix/ppc64        freebsd/amd64   linux/mipsle   openbsd/386
# > android/386      freebsd/arm     linux/ppc64    openbsd/amd64
# > android/amd64    illumos/amd64   linux/ppc64le  openbsd/arm
# > android/arm      js/wasm         linux/s390x    openbsd/arm64
# > android/arm64    linux/386       nacl/386       plan9/386
# > darwin/386       linux/amd64     nacl/amd64p32  plan9/amd64
# > darwin/amd64     linux/arm       nacl/arm       plan9/arm
# > darwin/arm       linux/arm64     netbsd/386     solaris/amd64
# > darwin/arm64     linux/mips      netbsd/amd64   windows/386
# > dragonfly/amd64  linux/mips64    netbsd/arm     windows/amd64
# > freebsd/386      linux/mips64le  netbsd/arm64   windows/arm


function funBootstrap() {
  # TODO:(feature) Install go SDK if not found.
  go tool dist install -v pkg/runtime
  go install -v -a std
}

funBootstrap

readonly BUILD_DIR="build_gitignore"
if [[ ! -d ${BUILD_DIR} ]] ; then
  mkdir ${BUILD_DIR}
fi
if [[ ! -d ${BUILD_DIR} ]] ; then
  cat << __EOF
Aborting build now due to:
   Could not create `${BUILD_DIR}` directory.
   Recheck file system permissions:
__EOF
  exit 1
fi


for OS in ${OS_L} ; do
  for ARCH in ${ARCH_L} ; do
    GOOS=${OS}
    GOARCH=${ARCH}
    echo "${GOOS}.${GOARCH} {{{"
    BIN_NAME=webServer.${GOOS}_${GOARCH}_gitignore
    if [[ ${GOOS} == "windows" ]] ; then
      BIN_NAME=${BIN_NAME}.exe
    fi
    go build -o ${BIN_NAME}
    echo "${GOOS}.${GOARCH} }}}"
  done
done
