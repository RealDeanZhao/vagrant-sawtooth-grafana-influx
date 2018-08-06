#!/bin/sh
echo "Installing grafana........."
# git clone https://github.com/hyperledger/sawtooth-core.git
# cd sawtooth-core/docker
# docker build . -f grafana/sawtooth-stats-grafana -t 10.244.76.52:5000/xiaoyudian/sawtooth-stats-grafana

# docker run -d -p 3000:3000 --name sawtooth-stats-grafana 10.244.76.52:5000/xiaoyudian/sawtooth-stats-grafana
apt-get install -y adduser libfontconfig
apt-get install -y grafana
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server

echo "Grafana installed.........."