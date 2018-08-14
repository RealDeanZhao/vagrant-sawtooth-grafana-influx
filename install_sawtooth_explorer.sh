
#!/bin/bash
echo "Installing sawtooth explorer......"
apt-get install nginx -y
rm /etc/nginx/sites-enabled/default
cp /share/nginx/sawtooth-explorer.conf /etc/nginx/conf.d/sawtooth-explorer.conf

systemctl restart nginx

mkdir -p /var/www/sawtooth-explorer
cp -r /share/sawtooth-explorer/* /var/www/sawtooth-explorer
echo "Sawtooth explorer installed......"
