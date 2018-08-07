#!/bin/bash
echo "Installing grafana........."

apt-get install -y adduser libfontconfig
apt-get install -y grafana

sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server

timeout 10 bash -c "until </dev/tcp/192.168.57.101/3000; do sleep 1; done"

curl -i -H "Content-Type: application/json" \
    --user admin:admin \
    -XPOST http://$1:3000/api/datasources  \
    -d '{
        "database": "sawtooth_metrics", 
        "name": "metrics", 
        "password": "lrdata-pw", 
        "user": "lrdata", 
        "type": "influxdb", 
        "url": "http://'$1':8086",
        "access": "proxy"
    }'

curl -i -H "Content-Type: application/json" \
    --user admin:admin \
    -XPOST http://$1:3000/api/dashboards/db  \
    -d @/share/grafana_dashboard_sawtooth_performance.json

echo "Grafana installed.........."