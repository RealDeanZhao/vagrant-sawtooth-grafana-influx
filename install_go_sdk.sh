#!/bin/bash

apt-get install -y --allow \
    libssl-dev \
    libzmq3-dev \
    openssl \
    protobuf-compiler \
    python3 \
    python3-grpcio \
    python3-grpcio-tools \
    python3-pkg-resources \
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
gvm install go1.10.2
gvm use go1.10.2 --default
# sudo -u vagrant -H bash -c 'echo "source /home/vagrant/.gvm/scripts/gvm" >> /home/vagrant/.bashrc'
# sudo -u vagrant -H bash -c 'source /home/vagrant/.gvm/scripts/gvm; gvm install go1.10.2'
# sudo -u vagrant -H bash -c 'source /home/vagrant/.gvm/scripts/gvm; gvm use go1.10.2 --default'
# sudo -u vagrant -H bash -c 'source /home/vagrant/.gvm/scripts/gvm; go get github.com/kr/godep'

# source /home/vagrant/.gvm/scripts/gvm

go get -u github.com/hyperledger/sawtooth-sdk-go \
    github.com/btcsuite/btcd/btcec \
    github.com/golang/protobuf/proto \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/golang/mock/gomock \
    github.com/golang/mock/mockgen \
    github.com/pebbe/zmq4 \
    github.com/satori/go.uuid


cd $GOPATH/src/github.com/hyperledger/sawtooth-sdk-go
go generate

if [ $1 -eq 1 ]; then
    unset http_proxy
    unset https_proxy
fi