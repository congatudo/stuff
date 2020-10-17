#!/bin/sh
echo "Reseting iptables...."
set -x
iptables         -F OUTPUT
iptables  -t nat -F OUTPUT
dest=YOURIP

for host in 8.209.93.40 47.254.171.96 47.254.184.155 8.209.94.94 8.209.94.20 8.209.93.40 8.209.93.82 47.91.91.199 47.254.169.195 47.91.77.57; do
  iptables  -t nat -A OUTPUT -p tcp --dport 4010   -d $host -j DNAT --to-destination $dest:4010
  iptables  -t nat -A OUTPUT -p tcp --dport 4030   -d $host -j DNAT --to-destination $dest:4030
  iptables  -t nat -A OUTPUT -p tcp --dport 4050   -d $host -j DNAT --to-destination $dest:4050
done
echo "iptables ok..."

echo "Starting services...."
/etc/rc.d/S90robotManager start

