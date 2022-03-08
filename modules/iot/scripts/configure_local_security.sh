#!/bin/bash
#set -x

firewall-cmd --zone=public --permanent --add-port=80/tcp
firewall-cmd --zone=public --permanent --add-port=443/tcp
firewall-cmd --zone=public --permanent --add-port=6446/tcp
firewall-cmd --zone=public --permanent --add-port=6448/tcp
firewall-cmd --zone=public --permanent --add-port=1883/tcp
firewall-cmd --zone=public --permanent --add-port=8883/tcp
firewall-cmd --reload

/usr/bin/update-crypto-policies --set LEGACY

echo "Local Security Granted !"
echo "Crypto Policies changed, reboot might be required !"
