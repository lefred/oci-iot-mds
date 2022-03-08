#!/bin/bash
#set -x

dnf install -y mysql-router

echo "[routing:primary]
bind_address = 0.0.0.0
bind_port = 6446
destinations = ${mds_ip}:3306
routing_strategy = first-available

[routing:primary_x]
bind_address = 0.0.0.0
bind_port = 6448
destinations = ${mds_ip}:33060
routing_strategy = first-available
protocol = x" >> /etc/mysqlrouter/mysqlrouter.conf

systemctl enable mysqlrouter
systemctl start mysqlrouter

echo "MySQL Router installed and started !"
