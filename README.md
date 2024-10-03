---

# Nginx Reverse Proxy

This repository demonstrates how to set up an Nginx server as a reverse proxy. Nginx can be used to efficiently route traffic to different backend services, helping to improve security, load balancing, and performance for web applications.

## Features

- **Reverse Proxy**: Acts as an intermediary for client requests, passing them to backend servers.
- **Load Balancing**: Distributes incoming requests across multiple backend servers for better performance.
- **SSL/TLS Support**: Can be configured with SSL certificates to ensure secure communication.
- **Customizable**: The configuration can be tailored to meet the specific needs of various web applications.

## Prerequisites

1. **Docker**: Ensure Docker is installed. You can download Docker from [here](https://docs.docker.com/get-docker/).
2. **Nginx**: You must have Nginx set up on your server. For installation instructions, refer to the [Nginx documentation](https://nginx.org/en/docs/install.html).

## Installation

1. Clone the repository to your local machine:
    ```bash
    git clone https://github.com/wildanazz/nginx-reverse-proxy.git
    ```

2. Navigate to the project directory:
    ```bash
    cd nginx-reverse-proxy
    ```

3. Build and start the Docker container:
    ```bash
    docker-compose up --build
    ```

## Configuration

The core of the reverse proxy functionality lies in the `nginx.conf` file located in the `/config` directory. Here's a basic breakdown:

- **server block**: This defines the port on which Nginx listens (default: 80) and the location block to handle the reverse proxy.
  
- **location block**: Directs incoming traffic to the appropriate backend service using the `proxy_pass` directive.

### Sample Configuration (`nginx.conf`)

```nginx
server {
    listen 80;
    server_name example.com;

    location / {
        proxy_pass http://backend_service:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

You can modify this to match your own service's address and port.

## SSL/TLS Setup

For enhanced security, you can configure SSL using Let's Encrypt. To enable SSL, you'll need to modify your Nginx configuration file:

1. Install Certbot to manage SSL certificates.
2. Update the `nginx.conf` file to listen on port 443 and use your SSL certificates.

```nginx
server {
    listen 443 ssl;
    server_name example.com;

    ssl_certificate /etc/ssl/certs/your_domain.crt;
    ssl_certificate_key /etc/ssl/private/your_domain.key;

    location / {
        proxy_pass http://backend_service:3000;
    }
}
```

## Usage

Once the proxy is set up, you can access your backend services through the Nginx server. This will provide an additional layer of security and load balancing.

### Monitoring

To monitor logs for troubleshooting, use:
```bash
docker-compose logs -f nginx
```

## Contributions

Feel free to contribute by forking this repository, creating new issues, or submitting pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](./LICENSE) file for details.

---
