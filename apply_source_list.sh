#!/bin/bash

sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/mirrors.aliyun.com\/ubuntu\//g' /etc/apt/sources.list

curl -sL https://mirrors.tuna.tsinghua.edu.cn/influxdata/influxdb.key | apt-key add -
apt-add-repository "deb https://mirrors.tuna.tsinghua.edu.cn/influxdata/ubuntu xenial stable"

curl https://packagecloud.io/gpg.key | sudo apt-key add -
sudo add-apt-repository "deb https://mirrors.tuna.tsinghua.edu.cn/grafana/apt/ stretch main"

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8AA7AF1F1091A5FD
add-apt-repository 'deb http://repo.sawtooth.me/ubuntu/1.0/stable xenial universe'
add-apt-repository 'deb http://repo.sawtooth.me/ubuntu/ci xenial universe'

# curl -fsSL https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository \
#    "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"
apt-get update -y
