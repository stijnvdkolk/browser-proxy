# Browser Proxy

A lightweight Docker container that creates an HTTP proxy server routing traffic through an OpenVPN connection. Perfect for securely browsing the web through a VPN connection from any application that supports HTTP proxies.

## Features

- 🔒 Routes all HTTP/HTTPS traffic through OpenVPN
- 🚀 Lightweight Alpine Linux base (< 50MB)
- 🌐 HTTP proxy on port 8888
- 🔍 Built-in health checks
- 📊 Configurable logging and connection limits
- 🛡️ Enhanced privacy with disabled Via headers

## Quick Start

### Prerequisites

- Docker and Docker Compose
- OpenVPN configuration file (`.ovpn`)

### Usage

1. **Clone the repository:**
   ```bash
   git clone https://github.com/stijnvdkolk/browser-proxy.git
   cd browser-proxy
   ```

2. **Prepare your OpenVPN configuration:**
   ```bash
   # Place your OpenVPN config in the openvpn directory
   cp your-config.ovpn openvpn/client.ovpn
   ```

3. **Start the proxy:**
   ```bash
   # Copy the example compose file
   cp docker-compose.example.yaml docker-compose.yaml
   
   # Start the service
   docker-compose up -d
   ```

4. **Configure your browser or application:**
   - **Proxy Type:** HTTP
   - **Host:** `127.0.0.1`
   - **Port:** `8888`

## Docker Images

Pre-built images are available on both GitHub Container Registry and Docker Hub:

```bash
# GitHub Container Registry
docker pull ghcr.io/stijnvdkolk/browser-proxy:latest

# Docker Hub
docker pull stijnvdkolk/browser-proxy:latest
```

## Configuration

### Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `TZ` | `UTC` | Timezone for the container |

### Volumes

| Host Path | Container Path | Description |
|-----------|----------------|-------------|
| `./openvpn/client.ovpn` | `/etc/openvpn/client.ovpn` | Your OpenVPN configuration file |

### Ports

| Container Port | Host Port | Description |
|----------------|-----------|-------------|
| `8888` | `127.0.0.1:8888` | HTTP proxy server |


## Health Checks

The container includes built-in health checks that verify the proxy is responding on port 8888 and the VPN connection is active.

## Development

### Building Locally

```bash
# Build the image
docker build -t browser-proxy .

# Run with docker-compose
docker-compose up -f docker-compose.example.yaml --build
```

### Testing

Test the proxy connection:
```bash
# Check your IP without proxy
curl http://httpbin.org/ip

# Check your IP through the proxy
curl -x 127.0.0.1:8888 http://httpbin.org/ip
```

The IPs should be different, indicating traffic is routed through the VPN.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is open source. Please check the license file for details.

## Disclaimer

This tool is provided for legitimate privacy and security purposes. Users are responsible for complying with all applicable laws and terms of service when using VPN services and proxy tools.
