# CDN
A CDN, or Content Delivery Network, uses servers at distributed locations.
It can store images, CSS, and JavaScript closer to users.
Serving content from a nearby edge can shorten the path and reduce latency.
Cache hits can also reduce the load on the origin.

The origin server is the primary content source. An edge server can be closer to the user and
can serve a cached copy. On a cache miss, it may fetch content from the origin.

Example from the hint:
```bash
curl -I https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js
```
Recorded output is in cdn_headers_test.txt.
Headers to inspect include X-Cache, CF-Cache-Status, and X-Served-By.
In relevant cache-status headers, HIT indicates a cache hit and MISS indicates a miss for that request.
CDNs expose different headers; a missing particular header does not prove the absence of a CDN.
