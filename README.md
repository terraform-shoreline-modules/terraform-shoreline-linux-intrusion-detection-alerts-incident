
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Intrusion Detection Alerts Incident

An Intrusion Detection Alerts Incident occurs when an intrusion detection system (IDS) detects a security breach or unauthorized access attempt to a system or network. The IDS generates an alert to notify security personnel to investigate the incident and take appropriate action to prevent any potential damage or data loss. This incident type is critical as it helps to identify and respond to security threats in a timely manner.

### Parameters

```shell
export INTRUSION_DETECTION_SYSTEM="PLACEHOLDER"
export LOG_DIRECTORY="PLACEHOLDER"
export REPLACE_WITH_NECESSARY_PORT_NUMBER="PLACEHOLDER"
export REPLACE_WITH_MINIMUM_PASSWORD_AGE="PLACEHOLDER"
export REPLACE_WITH_DEFAULT_UMASK="PLACEHOLDER"
export REPLACE_WITH_MAXIMUM_PASSWORD_AGE="PLACEHOLDER"
export REPLACE_WITH_PASSWORD_WARNING_PERIOD="PLACEHOLDER"
```

## Debug

### Find the intrusion detection system logs

```shell
grep -r "${LOG_DIRECTORY}" -e "${INTRUSION_DETECTION_SYSTEM}"
```

### Check system logs for unusual activity

```shell
journalctl -k | grep -i "intrusion\|security"
```

### Check iptables rules for any unexpected ports or IP addresses

```shell
iptables -L -n -v
```

### Check network connections

```shell
netstat -tulanp
```

### Check running processes

```shell
ps -aux
```

### Check user accounts

```shell
cat /etc/passwd
```

### Check system configuration

```shell
cat /etc/sysctl.conf
```

### Check for any unauthorized changes to system startup scripts

```shell
ls -la /etc/init.d/
```

## Repair

### Harden system configurations and policies, and deploy additional security measures such as firewalls and intrusion detection systems.

```shell
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
```