
#!/bin/bash
echo "Configuring sawtooth........"
tee /etc/sawtooth/validator.toml <<- EOF
bind = [
    "network:tcp://$1:8800",
    "component:tcp://0.0.0.0:4004"
]
peering = "dynamic"
endpoint = "tcp://$1:8800"
opentsdb_url = "http://$3:8086"
opentsdb_db = "sawtooth_metrics"
opentsdb_username = "lrdata"
opentsdb_password = "lrdata-pw"
EOF

# 如果是其他节点, 那么则需要配置seeds
if [ $2 -eq 1 ]; then
  tee -a /etc/sawtooth/validator.toml <<- EOF
seeds = [
  "tcp://$3:8800"
]
EOF
fi

tee /etc/sawtooth/settings.toml <<- 'EOF'
connect = "tcp://0.0.0.0:4004"
EOF

tee /etc/sawtooth/xo.toml <<- 'EOF'
connect = "tcp://0.0.0.0:4004"
EOF

tee /etc/sawtooth/rest_api.toml <<- 'EOF'
bind = [
  "0.0.0.0:8008"
]

connect = "tcp://127.0.0.1:4004"
EOF

sawtooth keygen
sawadm keygen
if [ $2 -eq 0 ]; then
  # 生成genesis配置
  sawset genesis
  # 生成poet的配置
  sawset proposal create -o config.batch \
    sawtooth.consensus.algorithm=poet \
    sawtooth.poet.report_public_key_pem="$(cat /etc/sawtooth/simulator_rk_pub.pem)" \
    sawtooth.poet.valid_enclave_measurements=$(poet enclave measurement) \
    sawtooth.poet.valid_enclave_basenames=$(poet enclave basename)
  # 注册poet, 这个是必须得
  poet registration create -o poet.batch

  sawadm genesis config-genesis.batch config.batch poet.batch
fi

systemctl restart sawtooth-validator
systemctl restart sawtooth-poet-validator-registry-tp
systemctl restart sawtooth-settings-tp
systemctl restart sawtooth-xo-tp-python
systemctl restart sawtooth-rest-api

#chown sawtooth:sawtooth /var/lib/sawtooth/poet*

echo "Sawtooth configured........"