#!/bin/bash

set -x

# For Postgres performance
sysctl -w kernel.shmmax=17179869184

# Disable IPv6
sysctl net.ipv6.conf.lo.disable_ipv6=0

# Start this so that `supermarket-ctl` sv-related commands can interact with its services via runsv
# Reconfigure and start all the service for Chef Supermarket
(/opt/supermarket/embedded/bin/runsvdir-start &) && supermarket-ctl reconfigure

# Install postfix for email notification
if [[ $(dpkg-query -l | grep postfix | wc -l) < 1 ]]; then
    apt-get update
    chmod +x /install_postfix.sh
    /install_postfix.sh
    rm -rf /var/lib/apt/lists/*
fi

# Restart the postfix service
service postfix restart

supermarket-ctl tail

exec "$@"
