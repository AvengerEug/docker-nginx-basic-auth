#!/bin/sh

set -e

if [ -z $USERNAME ]; then
  echo >&2 "USERNAME must be set"
  exit 1
fi

if [ -z $PASSWORD ]; then
  echo >&2 "PASSWORD must be set"
  exit 1
fi

htpasswd -bBc /etc/nginx/.htpasswd $USERNAME $PASSWORD
sed \
  -e "s/##PORT##/$PORT/g" \
  nginx.conf.tmpl > /etc/nginx/nginx.conf

exec nginx -g "daemon off;"
