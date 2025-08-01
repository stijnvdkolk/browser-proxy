# Contributing to Browser Proxy

Thank you for your interest in contributing to Browser Proxy! This document provides guidelines and information for contributors.

## Development Setup

### Prerequisites

- Docker and Docker Compose
- Git
- A valid OpenVPN configuration file for testing

### Local Development

1. **Fork and clone the repository:**
   ```bash
   git clone https://github.com/stijnvdkolk/browser-proxy.git
   cd browser-proxy
   ```

2. **Set up your development environment:**
   ```bash
   # Copy the example compose file
   cp docker-compose.example.yaml docker-compose.yaml
   
   # Add your test OpenVPN config
   cp your-test-config.ovpn openvpn/client.ovpn
   ```

3. **Build and test locally:**
   ```bash
   # Build the image
   docker build -t browser-proxy-dev .
   
   # Run the container
   docker-compose up --build
   ```

## Making Changes

### Code Style

- Use consistent indentation (2 spaces for YAML, 4 spaces for shell scripts)
- Add comments for complex logic
- Follow Docker best practices
- Keep the Alpine base image lightweight

### Testing Your Changes

1. **Build and run the container:**
   ```bash
   docker-compose up --build
   ```

2. **Test proxy functionality:**
   ```bash
   # Test without proxy
   curl http://httpbin.org/ip
   
   # Test with proxy (should show different IP)
   curl -x 127.0.0.1:8888 http://httpbin.org/ip
   ```

3. **Check health status:**
   ```bash
   docker-compose ps
   ```

4. **Review logs:**
   ```bash
   docker-compose logs -f vpn-proxy
   ```

### Configuration Changes

If you modify configuration files:

- **Dockerfile**: Test with `docker build -t test-image .`
- **tinyproxy.conf**: Ensure proxy still works after changes
- **entrypoint.sh**: Test startup sequence and error handling
- **docker-compose.example.yaml**: Verify all services start correctly

## Submitting Changes

### Pull Request Process

1. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes:**
   - Write clear, concise commit messages
   - Test thoroughly
   - Update documentation if needed

3. **Submit a pull request:**
   - Provide a clear description of changes
   - Reference any related issues
   - Include testing steps

### Pull Request Guidelines

- **Title**: Use a clear, descriptive title
- **Description**: Explain what changes were made and why
- **Testing**: Describe how you tested the changes
- **Documentation**: Update README.md if user-facing changes were made

## Types of Contributions

### Bug Reports

When reporting bugs, please include:

- **Environment**: OS, Docker version, etc.
- **Steps to reproduce**: Clear, numbered steps
- **Expected behavior**: What should happen
- **Actual behavior**: What actually happens
- **Logs**: Relevant container logs
- **Configuration**: Sanitized config files (remove sensitive data)

### Feature Requests

For new features:

- **Use case**: Explain why this feature would be useful
- **Implementation**: Suggest how it might work
- **Alternatives**: Any alternative solutions considered
- **Breaking changes**: Note if this would break existing functionality

### Documentation Improvements

Documentation contributions are always welcome:

- Fix typos or unclear instructions
- Add examples or use cases
- Improve troubleshooting guides
- Translate documentation

## Security Considerations

### Reporting Security Issues

**Do not** report security vulnerabilities through public GitHub issues.

Instead:
- Email security issues privately to the maintainers
- Provide detailed information about the vulnerability
- Allow time for the issue to be addressed before public disclosure

### Security Guidelines

- Never commit sensitive data (VPN configs, passwords, keys)
- Be cautious with proxy access controls
- Consider security implications of configuration changes
- Test security features thoroughly

## Release Process

Releases are handled by maintainers:

1. **Version tagging**: Using semantic versioning (v1.0.0)
2. **Automated builds**: GitHub Actions builds and pushes images
3. **Release notes**: Document changes and breaking changes
4. **Docker registries**: Images pushed to GHCR and Docker Hub

## Getting Help

- **Questions**: Open a GitHub Discussion
- **Issues**: Use GitHub Issues for bugs and feature requests
- **Chat**: Check if there's a community chat/Discord

## Code of Conduct

Please be respectful and constructive in all interactions. This project follows standard open-source community guidelines:

- Be welcoming to newcomers
- Be respectful of differing viewpoints
- Focus on what's best for the community
- Show empathy towards other contributors

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.

Thank you for contributing! 🎉
