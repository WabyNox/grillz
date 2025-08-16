# [Recon] Basic scan (no DNS resolution) --nmap
nmap -Pn <target>

# [Recon] Quick scan of top 1000 ports --nmap
nmap <target>

# [Recon] Scan specific ports --nmap
nmap -p <port1,port2,range> <target>

# [Recon] Scan all ports (1–65535) --nmap
nmap -p- <target>

# [Recon] Aggressive scan (OS, version, scripts, traceroute) --nmap
nmap -A <target>

# [Recon] Enable OS detection --nmap
nmap -O <target>

# [Recon] Service/version detection --nmap
nmap -sV <target>

# [Recon] Detect service versions on specific ports --nmap
nmap -sV -p <ports> <target>

# [Enumeration] TCP connect scan --nmap
nmap -sT <target>

# [Enumeration] SYN scan (default, stealthier) --nmap
nmap -sS <target>

# [Enumeration] UDP scan (common UDP ports) --nmap
nmap -sU <target>

# [Enumeration] TCP and UDP scan combined --nmap
nmap -sS -sU <target>

# [Enumeration] Script scan (default set) --nmap
nmap -sC <target>

# [Enumeration] Script scan with category --nmap
nmap --script <category> <target>

# [Enumeration] Run specific NSE script --nmap
nmap --script <script_name> <target>

# [Enumeration] Save results in all formats --nmap
nmap -oA <basename> <target>

# [Enumeration] Save results in greppable format --nmap
nmap -oG <file> <target>

# [Enumeration] Timing template (faster scans) --nmap
nmap -T<0-5> <target>

# [Enumeration] Detect firewall with ACK scan --nmap
nmap -sA <target>

# [Enumeration] Null scan (no flags) --nmap
nmap -sN <target>

# [Enumeration] FIN scan --nmap
nmap -sF <target>

# [Enumeration] Xmas scan --nmap
nmap -sX <target>

# [Enumeration] Fragment packets (evade IDS/IPS) --nmap
nmap -f <target>

# [Enumeration] Spoof source IP --nmap
nmap -S <spoofed_ip> <target>

# [Enumeration] Spoof MAC address --nmap
nmap --spoof-mac <MAC|0|vendor> <target>

# [Enumeration] Use decoys to hide origin --nmap
nmap -D RND:10 <target>

# [Enumeration] Idle/zombie scan --nmap
nmap -sI <zombie_ip> <target>

# [Exploitation] SMB vuln scan with scripts --nmap
nmap --script smb-vuln* -p445 <target>

# [Exploitation] HTTP vuln scan with scripts --nmap
nmap --script http-vuln* -p80,443 <target>

# [Exploitation] Heartbleed vuln scan --nmap
nmap --script ssl-heartbleed -p443 <target>

# [Post-Exploitation] Host discovery in internal subnet --nmap
nmap -sn <subnet/CIDR>

# [Post-Exploitation] Detect open shares with SMB script --nmap
nmap --script smb-enum-shares -p445 <target>
