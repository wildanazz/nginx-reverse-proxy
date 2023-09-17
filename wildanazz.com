server {
	listen 80;
	listen [::]:80;

	server_name wildanazz.com www.wildanazz.com;

	if ($host = www.wildanazz.com) {
		return 301 https://$host$request_uri;
	}

	if ($host = wildanazz.com) {
		return 301 https://$host$request_uri;
	}

	return 404;
}

server {
	listen 443 ssl;
	listen [::]:443 ssl ipv6only=on;

	server_name wildanazz.com www.wildanazz.com;

	ssl_certificate /etc/letsencrypt/live/wildanazz.com/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/wildanazz.com/privkey.pem;
	include /etc/letsencrypt/options-ssl-nginx.conf;
	ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

	location / {
		proxy_set_header Host $http_host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header X-Forwarded-Proto $scheme;
		proxy_pass http://127.0.0.1:3000;
	}
}
