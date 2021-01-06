#!/usr/bin/env sh
set -eu

# set config up for rproxy
envsubst '${UPSTREAM}' < /apache.conf > /etc/apache2/sites-available/000-default.conf

# create directory
mkdir -p /cert

if [ ! -f /cert/cert.pem ]; then
    echo "/cert/cert.pem does not exist... creating cert"
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
        -subj "/C=AU/ST=None/L=None/O=None/CN=$HOST" \
        -keyout /cert/cert.key  -out /cert/cert.pem
    chmod 400 /cert/cert.key
    echo "cert created"
fi

exec "$@"
