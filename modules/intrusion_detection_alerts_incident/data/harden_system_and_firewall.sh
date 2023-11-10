#!/bin/bash

# Harden system configurations and policies
sed -i 's/PASS_MAX_DAYS ${REPLACE_WITH_MAXIMUM_PASSWORD_AGE}/PASS_MAX_DAYS 90/g' /etc/login.defs
sed -i 's/PASS_MIN_DAYS ${REPLACE_WITH_MINIMUM_PASSWORD_AGE}/PASS_MIN_DAYS 7/g' /etc/login.defs
sed -i 's/PASS_WARN_AGE ${REPLACE_WITH_PASSWORD_WARNING_PERIOD}/PASS_WARN_AGE 14/g' /etc/login.defs
sed -i 's/UMASK ${REPLACE_WITH_DEFAULT_UMASK}/UMASK 027/g' /etc/login.defs
sed -i 's/#DefaultLimitNOFILE=/DefaultLimitNOFILE=65535/g' /etc/systemd/user.conf
sed -i 's/#DefaultLimitNPROC=/DefaultLimitNPROC=65535/g' /etc/systemd/user.conf

# Install and configure firewall
yum -y install firewalld
systemctl start firewalld
systemctl enable firewalld
firewall-cmd --zone=public --add-port=${REPLACE_WITH_NECESSARY_PORT_NUMBER}/tcp --permanent
firewall-cmd --reload

# Install and configure intrusion detection system
yum -y install snort
systemctl start snort
systemctl enable snort