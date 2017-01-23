#!/bin/sh

echo "~~ Kontena Registry ~~"
echo ""

case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@" ;;
esac

if [ -n "$AUTH_PASSWORD" ]; then
  echo "* authentication enabled"
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

echo ""

exec "$@"
