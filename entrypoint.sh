#!/bin/sh
set -e

# Check if OpenVPN config exists
if [ ! -f /etc/openvpn/client.ovpn ]; then
    echo "ERROR: OpenVPN config not found at /etc/openvpn/client.ovpn"
    echo "Please mount your OpenVPN config file to /etc/openvpn/client.ovpn"
    exit 1
fi

echo "Starting OpenVPN..."
# Start OpenVPN in background
openvpn --config /etc/openvpn/client.ovpn --daemon --log /var/log/openvpn.log

# Wait for VPN connection
echo "Waiting for VPN connection..."
timeout=60
counter=0
while [ $counter -lt $timeout ]; do
    if ip link show tun0 >/dev/null 2>&1; then
        echo "✓ VPN connected!"
        break
    fi
    sleep 2
    counter=$((counter + 2))
done

if [ $counter -ge $timeout ]; then
    echo "ERROR: VPN connection timeout"
    echo "OpenVPN log:"
    cat /var/log/openvpn.log
    exit 1
fi

# Set up routing through VPN
echo "Setting up traffic routing..."
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
iptables -A FORWARD -i tun0 -j ACCEPT
iptables -A FORWARD -o tun0 -j ACCEPT

echo "Starting TinyProxy on port 8888..."
exec tinyproxy -d
