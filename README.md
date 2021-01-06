# https-dev-proxy
Apache httpd as an SSL offloader and reverse proxy, with a self-signed certificate.

This is intended for dev purposes only, typically where you need to test how an application running behind an SSL offloading reverse proxy will work.  It generates a self-signed certificate when it first starts.

## How to use

1. Clone the repo ``git clone``
2. Build the image ``docker build . -t https``
3. Run

```bash
docker run \
  -e UPSTREAM="upstream server, port & path e.g. app:5000/" \
  -e HOST="name of host for self-signed certificate - typically localhost" \
  -p 8443:443 \
  https
```

