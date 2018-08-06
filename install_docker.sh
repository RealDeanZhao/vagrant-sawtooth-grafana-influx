#!/bin/bash

echo "Installing docker.........."
apt-get remove docker docker-engine docker.io
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

apt-get install -y docker-ce

# 配置docker镜像加速
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://a7zezo1t.mirror.aliyuncs.com"],
  "insecure-registries" : ["10.244.76.52:5000"]
}
EOF

systemctl daemon-reload
systemctl restart docker
echo "Docker installed..........."