# DNS Record Types
|Type|Explanation|Real use case|
|---|---|---|
|A|Maps a name to IPv4|IPv4 address for google.com|
|AAAA|Maps a name to IPv6|IPv6 access to google.com|
|CNAME|Aliases one name to another|The www.wikipedia.org alias|
|MX|Mail exchanger and preference|Incoming mail servers for cloudflare.com|
|TXT|Text associated with a domain|An SPF record for example.com|
|NS|Authoritative name server|Name servers for cloudflare.com|
|SOA|Zone administration such as serial and refresh|Zone management for cloudflare.com|

A lower MX preference value is preferred. A CNAME target is a name, not an IP address.
TTL is the number of seconds a record can remain cached.
An authoritative NS for a domain differs from the resolver configured on the host.

```bash
dig google.com A
dig google.com AAAA
dig www.wikipedia.org CNAME
dig google.com MX
dig google.com TXT
dig google.com NS
dig google.com SOA
```
Recorded results are in dns_record_examples.txt.
Run bash collect_examples.sh to collect fresh examples.
Some Google queries received no answer in the recorded network; MX, NS, and SOA examples
were also collected from cloudflare.com, and TXT examples from example.com.
