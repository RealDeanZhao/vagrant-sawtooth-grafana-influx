#!/bin/bash
echo "Installing sawtooth............."
apt-get install -y sawtooth
dpkg -l '*sawtooth*'
echo "Sawtooth installed.............."

echo "Installing sawtooth Seth"
cp /share/seth-bin/* /usr/bin
echo "Sawtooth Seth installed"