FROM alpine:3.22

# Metadata
LABEL org.opencontainers.image.title="Browser Proxy"
LABEL org.opencontainers.image.description="HTTP proxy that routes traffic through OpenVPN"
LABEL org.opencontainers.image.source="https://github.com/stijnvdkolk/browser-proxy"
LABEL org.opencontainers.image.licenses="MIT"

# Install required packages
RUN apk add --no-cache \
    openvpn \
    tinyproxy \
    iptables \
    curl \
    && rm -rf /var/cache/apk/*

# Copy configuration files
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint executable
RUN chmod +x /entrypoint.sh

# Expose proxy port
EXPOSE 8888

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -x localhost:8888 -s http://httpbin.org/ip || exit 1

ENTRYPOINT ["/entrypoint.sh"]
