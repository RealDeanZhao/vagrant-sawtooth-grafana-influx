#!/bin/bash
echo "Installing sawtooth............."
apt-get install -y sawtooth
dpkg -l '*sawtooth*'
echo "Sawtooth installed.............."

