# Lab 06 - SSL/TLS and HTTPS

English translations of the supplied answers, scripts, configurations, and historical output. No new remote test run is claimed. Identifying host values and sensitive headers are redacted in public reports; measurements remain historical observations.

## Files

- [certs/myapp.crt](certs/myapp.crt)
- [generate_ssl.sh](generate_ssl.sh)
- [https_server.py](https_server.py)
- [https_server_test.txt](https_server_test.txt)
- [https_test_report.txt](https_test_report.txt)
- [public/index.html](public/index.html)
- [ssl_best_practices.md](ssl_best_practices.md)
- [ssl_generation.txt](ssl_generation.txt)
- [test_https.sh](test_https.sh)

## Generate your own key

The original TLS private key is local-only. Run `bash generate_ssl.sh` in this directory to create a fresh certificate/key pair before starting the HTTPS example. Generated keys are ignored by Git.
