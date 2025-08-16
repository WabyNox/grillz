# [Recon] Subdomain brute-force via URL --ffuf
ffuf -u http://FUZZ.<domain>/ -w <subdomains_wordlist> -mc 200,301,302,403 -fs <wildcard_bytes>

# [Recon] Subdomain brute-force via Host header --ffuf
ffuf -u http://<domain>/ -H 'Host: FUZZ.<domain>' -w <subdomains_wordlist> -mc 200,301,302,403 -fs <wildcard_bytes>

# [Recon] Virtual host enumeration (vhosts) --ffuf
ffuf -u http://<base_domain>/ -H 'Host: FUZZ.<base_domain>' -w <vhosts_wordlist> -mc 200,301,302,403 -fs <wildcard_bytes>

# [Recon] Subdomain brute-force over HTTPS (ignore cert issues) --ffuf
ffuf -u https://FUZZ.<domain>/ -w <subdomains_wordlist> -mc 200,301,302,403 -fs <wildcard_bytes> -r

# [Recon] Subdomain brute-force via DNS-over-HTTP endpoint --ffuf
ffuf -u 'https://dns.example/api?name=FUZZ.<domain>' -w <subdomains_wordlist> -mc 200 -mr '<regex_match>'


# [Enumeration] Directory and file brute-force (basic) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -mc 200,204,301,302,307,401,403

# [Enumeration] Add common extensions (php, aspx, jsp, bak, zip) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -e .php,.aspx,.jsp,.bak,.zip -mc 200,301,302,403

# [Enumeration] Recursion with depth 2 (follow discovered dirs) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -recursion -recursion-depth 2 -mc 200,301,302,403

# [Enumeration] Greedy recursion strategy (broader traversal) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -recursion -recursion-strategy greedy -mc 200,301,302,403

# [Enumeration] Follow redirects (3xx) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -r -mc 200,204,301,302,307,401,403

# [Enumeration] Filter responses by size (hide wildcard pages) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -fs <bytes_to_filter>

# [Enumeration] Match specific response size --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -ms <bytes_to_match>

# [Enumeration] Filter by words/lines count --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -fw <words> -fl <lines>

# [Enumeration] Match by regex in body (content grep) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -mr '<regex>'

# [Enumeration] Only show selected HTTP status codes --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -mc 200,301,302,403

# [Enumeration] Exclude noisy HTTP status codes --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -fc 404,500

# [Enumeration] Increase speed (threads) + rate limit --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -t <threads> -rate <req_per_sec> -timeout <seconds> -retries <n>

# [Enumeration] Randomize delay between requests (OPSEC) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -p '<min_s>-<max_s>'

# [Enumeration] Auto-calibrate (reduce false positives) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -ac

# [Enumeration] Use HTTP proxy (e.g., Burp) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -x http://127.0.0.1:8080

# [Enumeration] Replay matches to proxy (inspect in Burp) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -replay-proxy http://127.0.0.1:8080 -mc 200,301,302,403

# [Enumeration] Add custom headers (auth, IP spoof, etc.) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -H 'Authorization: Bearer <token>' -H 'X-Forwarded-For: <spoofed_ip>'

# [Enumeration] Use cookies (session) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -b 'SESSION=<cookie>'

# [Enumeration] Set User-Agent --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -H 'User-Agent: <ua_string>'

# [Enumeration] Output results to JSON file --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -o <outfile.json> -of json

# [Enumeration] Quiet mode (clean output) --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -s


# [Enumeration] Fuzz parameter names (GET) --ffuf
ffuf -u '<url>?FUZZ=1' -w <param_names_wordlist> -mc 200,301,302,403

# [Enumeration] Fuzz parameter values (GET) --ffuf
ffuf -u '<url>?<param>=FUZZ' -w <param_values_wordlist> -mc 200,301,302,403

# [Enumeration] Fuzz multiple params with named wordlists (pitchfork/clusterbomb) --ffuf
ffuf -u '<url>?user=USER&pass=PASS' -w <userlist>:USER -w <passlist>:PASS -mc 200,301,302,403

# [Enumeration] Fuzz JSON body value (POST) --ffuf
ffuf -u <url> -X POST -H 'Content-Type: application/json' -d '{"key":"FUZZ"}' -w <wordlist> -mc 200,201,204

# [Enumeration] Fuzz form fields (POST x-www-form-urlencoded) --ffuf
ffuf -u <url> -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=USER&password=PASS' -w <userlist>:USER -w <passlist>:PASS -mc 200,302

# [Enumeration] Header value fuzzing (e.g., API keys) --ffuf
ffuf -u <url> -H 'X-Api-Key: FUZZ' -w <keys_wordlist> -mc 200

# [Enumeration] Path traversal attempt list --ffuf
ffuf -u '<url>/FUZZ' -w <traversal_payloads_wordlist> -mc 200,301,302,403

# [Enumeration] Read wordlist from stdin (e.g., numeric range) --ffuf
seq 1 <N> | ffuf -u '<url>?id=FUZZ' -w - -mc 200,302,403

# [Enumeration] Fuzz file names while keeping extension fixed --ffuf
ffuf -u '<url>/FUZZ.<ext>' -w <filenames_wordlist> -mc 200,301,302,403

# [Enumeration] Fuzz extensions for a fixed base name --ffuf
ffuf -u '<url>/<basename>.FUZZ' -w <extensions_wordlist> -mc 200,301,302,403

# [Enumeration] Crawl-like recursion with output directory per job --ffuf
ffuf -u <url>/FUZZ -w <wordlist> -recursion -recursion-depth <N> -o <out.json> -of json -od <outdir>
