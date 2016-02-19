#!/bin/bash

if [ -n "$AUTH_PASSWORD" ]; then
  htpasswd -Bbn "admin" "$AUTH_PASSWORD" > /htpasswd
  export REGISTRY_AUTH="htpasswd"
  export REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm"
  export REGISTRY_AUTH_HTPASSWD_PATH=/htpasswd
fi

if [ -n "$REGISTRY_HTTP_TLS_CERTIFICATE" ]; then
  mkdir -p /ssl
  echo -e "${REGISTRY_HTTP_TLS_CERTIFICATE}" > /ssl/cert.pem
  export REGISTRY_HTTP_TLS_CERTIFICATE="/ssl/cert.pem"
fi

if [ -n "$REGISTRY_HTTP_TLS_KEY" ]; then
  mkdir -p /ssl
  echo -e "${REGISTRY_HTTP_TLS_KEY}" > /ssl/key.pem
  export REGISTRY_HTTP_TLS_KEY="/ssl/key.pem"
fi

exec registry /etc/docker/registry/config.yml
