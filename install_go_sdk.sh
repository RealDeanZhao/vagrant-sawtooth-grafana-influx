#!/bin/bash
# $1 fuck GFW?
# $2 shadowsocks proxy ip
# $3 shadowsocks proxy port
apt-get install -y \
    libtool \
    pkg-config \
    autoconf \
    automake \
    uuid-dev \
    libssl-dev \
    libzmq3-dev \
    openssl \
    protobuf-compiler \
    python3 \
    python3-grpcio \
    python3-grpcio-tools \
    python3-pkg-resources \

apt-get install -y \
    curl \
    make \
    binutils \
    bison \
    gcc 
    

if [ $1 -eq 1 ]; then
    export http_proxy=http://$2:$3
    export https_proxy=http://$2:$3
fi

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /root/.gvm/scripts/gvm
gvm install go1.10.2 -B
gvm use go1.10.2 --default

go get -u github.com/hyperledger/sawtooth-sdk-go \
    github.com/btcsuite/btcd/btcec \
    github.com/golang/protobuf/proto \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/golang/mock/gomock \
    github.com/golang/mock/mockgen \
    github.com/pebbe/zmq4 \
    github.com/satori/go.uuid \
    github.com/brianolson/cbor_go \
    github.com/jessevdk/go-flags

cd $GOPATH/src/github.com/hyperledger/sawtooth-sdk-go
go generate

if [ $1 -eq 1 ]; then
    unset http_proxy
    unset https_proxy
fi