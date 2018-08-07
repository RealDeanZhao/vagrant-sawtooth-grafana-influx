#!/bin/bash
apt-get install -y golang-1.10-go \
    libssl-dev \
    libzmq3-dev \
    openssl \
    protobuf-compiler \
    python3 \
    python3-grpcio \
    python3-grpcio-tools \
    python3-pkg-resources

# echo "GOPATH=/home/vagrant/go"  >> /home/vagrant/.profile
echo "PATH=$HOME/bin:$HOME/.local/bin:/root/go/bin:/usr/lib/go-1.10/bin:$PATH"  >> /home/vagrant/.profile
if [ $1 -eq 1 ]; then
    echo "export http_proxy=http://$2:$3"  >> /home/vagrant/.profile
    echo "export https_proxy=http://$2:$3" >> /home/vagrant/.profile
fi

source /home/vagrant/.profile

go get -u github.com/hyperledger/sawtooth-sdk-go \
    github.com/btcsuite/btcd/btcec \
    github.com/golang/protobuf/proto \
    github.com/golang/protobuf/protoc-gen-go \
    github.com/golang/mock/gomock \
    github.com/golang/mock/mockgen \
    github.com/pebbe/zmq4 \
    github.com/satori/go.uuid

cd /root/go/src/github.com/hyperledger/sawtooth-sdk-go
go generate