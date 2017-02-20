FROM jboss/keycloak

ARG KEYCLOAK_ADMIN_USER=admin
ARG KEYCLOAK_ADMIN_PASSWORD=admin
ARG KEYCLOAK_IMPORT_REALM
ENV KEYCLOAK_IMPORT_REALM api-demo-realm.json
ENV KEYCLOAK_IMPORT_USERS api-demo-users-0.json

RUN /opt/jboss/keycloak/bin/add-user-keycloak.sh -u $KEYCLOAK_ADMIN_USER -p $KEYCLOAK_ADMIN_PASSWORD

ADD ${KEYCLOAK_IMPORT_REALM} /opt/jboss/keycloak/
ADD ${KEYCLOAK_IMPORT_USERS} /opt/jboss/keycloak/

ENTRYPOINT ["/bin/bash", "-c", "/opt/jboss/keycloak/bin/standalone.sh -Dkeycloak.import=/opt/jboss/keycloak/$KEYCLOAK_IMPORT_REALM -Dkeycloak.import=/opt/jboss/keycloak/$KEYCLOAK_IMPORT_REALM -b 0.0.0.0"]
