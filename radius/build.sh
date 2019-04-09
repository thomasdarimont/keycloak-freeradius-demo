#!/bin/bash

pushd .
KEYCLOAK_DIR=$(dirname $0)
cd $KEYCLOAK_DIR

docker build \
  -t tdlabs/freeradius-server:3.0.18.0 \
  -t tdlabs/freeradius-server:latest \
  .

popd
