#!/bin/sh

if [ -n "$AUTH_PASSWORD" ]; then
  htpasswd -Bbn "admin" "$AUTH_PASSWORD" > /htpasswd
  export REGISTRY_AUTH="htpasswd"
  export REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm"
  export REGISTRY_AUTH_HTPASSWD_PATH=/htpasswd
fi

exec registry /etc/docker/registry/config.yml
