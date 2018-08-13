#!/bin/bash

mv /etc/apt/sources.list /etc/apt/souces.list.old
tee /etc/apt/sources.list <<-'EOF'
deb http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-security main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-updates main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-proposed main restricted universe multiverse
deb-src http://mirrors.aliyun.com/ubuntu/ xenial-backports main restricted universe multiverse
EOF

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
