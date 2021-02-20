# UFW Utils

CLI Utilities for faster UFW configuration management.

## Rational

If UFW is your choice for managing iptables, and you decided to stop malicious actors from poking your servers?
You will soon to figure out that it takes hours to update over 60,000 rules through `ufw` CLI so your servers can only be accessed from US only for example.

Here https://www.countryipblocks.net/acl.php is the wonderful tool to get network IP ranges for the various configurations that might work for your use case. If not just grab CIDR list. (US list is already available in `us-ip-ranges.dat`)


## Enable only US traffic to HTTP/S port
`mk-user-rules-4-http-ranges.sh` utility will help to prepare `user.rules` changes quickly. It takes a file with CIDR list as input, and created a copy of `/etc/ufw/user.rules` file in working directory with rules added necessary to only allow traffic from that list to HTTP/S ports. 

Sample invocation (backup `/etc/ufw/user.rules` file first):

```
cp /etc/ufw/user.rules user.rules.back

mk-user-rules-4-http-ranges.sh us-ip-ranges.dat

cp user.rules /etc/ufw/user.rules

ufw reload
```

