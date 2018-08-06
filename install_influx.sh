#!/bin/bash
echo "Installing influx........."
apt-get install influxdb
systemctl enable influxdb.service
systemctl start influxdb

systemctl restart influxdb

timeout 10 bash -c "until </dev/tcp/127.0.0.1/8086; do sleep 1; done"
curl -i -XPOST http://127.0.0.1:8086/query --data-urlencode "q=CREATE DATABASE sawtooth_metrics"
curl -i -XPOST http://127.0.0.1:8086/query --data-urlencode "q=CREATE USER admin WITH PASSWORD 'admin-pw' WITH ALL PRIVILEGES"
curl -i -XPOST http://127.0.0.1:8086/query --data-urlencode "q=CREATE USER lrdata WITH PASSWORD 'lrdata-pw' WITH ALL PRIVILEGES"
curl -i -XPOST "http://127.0.0.1:8086/query?u=admin&p=admin-pw" --data-urlencode "q=GRANT ALL ON sawtooth_metrics TO lrdata"

echo "Influx installed.........."