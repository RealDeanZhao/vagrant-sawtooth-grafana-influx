#!/bin/bash
echo "Installing telegraf......."
apt-get install -y telegraf

tee -a /etc/telegraf/telegraf.conf <<- EOF
[[outputs.influxdb]]
  urls = ["http://$1:8086"]
  database = "sawtooth_metrics"
  username = "lrdata"
  password = "lrdata-pw"
EOF

systemctl restart telegraf
echo "Telegraf installed........"