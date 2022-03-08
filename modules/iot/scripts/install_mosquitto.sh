#!/bin/bash
#set -x

dnf install -y mosquitto mysql-connector-python3 certbot python3-paho-mqtt --enablerepo=ol8_developer_EPEL

mosquitto_passwd -c -b /etc/mosquitto/passwd "${mosquitto_username}" "${mosquitto_password}"

systemctl start mosquitto
systemctl enable mosquitto

echo "Mosquitto installed and started !"
