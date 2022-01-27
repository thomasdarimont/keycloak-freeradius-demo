#!/bin/bash
/opt/radius/scripts/docker-radius.sh
/opt/radius/scripts/radius-keycloak.sh
/opt/jboss/tools/docker-entrypoint.sh