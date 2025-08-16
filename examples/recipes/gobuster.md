# [Recon] DNS subdomain brute-force (basic) --gobuster
gobuster dns -d <domain> -w <wordlist>

# [Recon] DNS subdomain brute-force (show IPs) --gobuster
gobuster dns -d <domain> -w <wordlist> -i

# [Recon] DNS using custom resolver --gobuster
gobuster dns -d <domain> -w <wordlist> -r <resolver_ip:53>

# [Recon] DNS handle wildcard responses --gobuster
gobuster dns -d <domain> -w <wordlist> --wildcard

# [Recon] DNS increase threads --gobuster
gobuster dns -d <domain> -w <wordlist> -t <threads>

# [Recon] DNS output to file --gobuster
gobuster dns -d <domain> -w <wordlist> -o <outfile>

# [Recon] Enumerate public S3 buckets --gobuster
gobuster s3 -w <bucket_name_wordlist>

# [Recon] Enumerate public GCS buckets --gobuster
gobuster gcs -w <bucket_name_wordlist>

# [Recon] Discover files on TFTP server --gobuster
gobuster tftp -s <server_ip> -w <wordlist>

# [Recon] Save discovered subdomains to file --gobuster
gobuster dns -d <domain> -w <wordlist> -i -o subs.txt


# [Enumeration] Directory brute-force (basic) --gobuster
gobuster dir -u <url> -w <wordlist>

# [Enumeration] Directory brute-force with extensions --gobuster
gobuster dir -u <url> -w <wordlist> -x <ext1,ext2,ext3>

# [Enumeration] Show response length column --gobuster
gobuster dir -u <url> -w <wordlist> -l

# [Enumeration] Only show selected status codes --gobuster
gobuster dir -u <url> -w <wordlist> -s 200,204,301,302,307,401,403

# [Enumeration] Exclude specific status codes --gobuster
gobuster dir -u <url> -w <wordlist> -b 404,500

# [Enumeration] Exclude noisy responses by length --gobuster
gobuster dir -u <url> -w <wordlist> --exclude-length <bytes>

# [Enumeration] Append slash for directory checks --gobuster
gobuster dir -u <url> -w <wordlist> -f

# [Enumeration] Follow redirects --gobuster
gobuster dir -u <url> -w <wordlist> -r

# [Enumeration] Expanded output (print full URLs) --gobuster
gobuster dir -u <url> -w <wordlist> -e

# [Enumeration] Increase speed (threads) --gobuster
gobuster dir -u <url> -w <wordlist> -t <threads>

# [Enumeration] Add delay to reduce noise/rate limit --gobuster
gobuster dir -u <url> -w <wordlist> --delay <100ms|1s>

# [Enumeration] Custom timeout --gobuster
gobuster dir -u <url> -w <wordlist> --timeout <10s|30s>

# [Enumeration] Use proxy (e.g., Burp) --gobuster
gobuster dir -u <url> -w <wordlist> -p http://127.0.0.1:8080

# [Enumeration] Skip TLS verification (self-signed) --gobuster
gobuster dir -u <https_url> -w <wordlist> -k

# [Enumeration] Custom headers (e.g., auth) --gobuster
gobuster dir -u <url> -w <wordlist> -H 'Authorization: Bearer <token>' -H 'X-Forwarded-For: <ip>'

# [Enumeration] Use cookies --gobuster
gobuster dir -u <url> -w <wordlist> -c 'session=<cookie>'

# [Enumeration] Set User-Agent --gobuster
gobuster dir -u <url> -w <wordlist> -a '<user_agent>'

# [Enumeration] Output to file --gobuster
gobuster dir -u <url> -w <wordlist> -o <outfile>

# [Enumeration] Quiet mode (clean output) --gobuster
gobuster dir -u <url> -w <wordlist> -q


# [Enumeration] VHost brute-force (append domain) --gobuster
gobuster vhost -u http://<base_domain> -w <wordlist> --append-domain

# [Enumeration] VHost with HTTPS (skip cert verify) --gobuster
gobuster vhost -u https://<base_domain> -w <wordlist> -k --append-domain

# [Enumeration] VHost follow redirects --gobuster
gobuster vhost -u http://<base_domain> -w <wordlist> -r --append-domain

# [Enumeration] VHost over proxy (Burp) --gobuster
gobuster vhost -u http://<base_domain> -w <wordlist> -p http://127.0.0.1:8080 --append-domain


# [Enumeration] Path fuzzing with FUZZ keyword --gobuster
gobuster fuzz -u <url>/FUZZ -w <wordlist>

# [Enumeration] Parameter fuzzing (GET) --gobuster
gobuster fuzz -u <url>?<param>=FUZZ -w <wordlist>

# [Enumeration] Header fuzzing --gobuster
gobuster fuzz -u <url> -H 'X-Api-Key: FUZZ' -w <wordlist>

# [Enumeration] POST body fuzzing --gobuster
gobuster fuzz -u <url> -d '<key>=FUZZ&<key2>=<value2>' -w <wordlist>

# [Enumeration] Fuzz filter by response length --gobuster
gobuster fuzz -u <url>/FUZZ -w <wordlist> --exclude-length <bytes>

# [Enumeration] Fuzz tuning (threads & delays) --gobuster
gobuster fuzz -u <url>/FUZZ -w <wordlist> -t <threads> --delay <100ms>


# [Enumeration] VHost from discovered subdomains (file) --gobuster
cut -d' ' -f1 subs.txt | sed 's#^#http://#' | xargs -I{} gobuster vhost -u {} -w <vhosts_wordlist> --append-domain -q
