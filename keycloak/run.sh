#!/bin/bash

KEYCLOAK_DIR=$(dirname $0)
pushd .
cd $KEYCLOAK_DIR

docker run \
  -d \
  --name keycloakrds \
  -e KEYCLOAK_USER=admin \
  -e KEYCLOAK_PASSWORD=admin \
  -p 8180:8180 \
  -v `pwd`/data:/opt/jboss/keycloak/data \
  -v `pwd`/radiusdemo-realm.json:/opt/jboss/keycloak/radiusdemo-realm.json \
  -it jboss/keycloak:6.0.1 \
  -b 0.0.0.0 \
  -Djboss.http.port=8180 \
  -Dkeycloak.migration.action=import \
  -Dkeycloak.migration.provider=singleFile \
  -Dkeycloak.migration.file=/opt/jboss/keycloak/radiusdemo-realm.json \
  -Dkeycloak.migration.strategy=OVERWRITE_EXISTING

popd