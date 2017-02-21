FROM jboss/wildfly

USER root
RUN yum -y install less

ENV AUTH_SERVER_HOST localhost
ENV AUTH_SERVER_PORT 8081

# Don't add keycloak adapter to wildfly because the Axway API GW will do the IAM
#ADD keycloak-wildfly-adapter-dist-2.5.0.Final.zip /opt/jboss/wildfly

# Add keycloak adapter
#RUN cd /opt/jboss/wildfly && unzip keycloak-wildfly-adapter-dist-2.5.0.Final.zip
#RUN cd /opt/jboss/wildfly/bin && ./jboss-cli.sh --file=adapter-install-offline.cli

# Standalone.xml modifications.
RUN sed -i -e "s/jboss.bind.address.management:127.0.0.1/jboss.bind.address.management:0.0.0.0/g" $JBOSS_HOME/standalone/configuration/standalone.xml

RUN /opt/jboss/wildfly/bin/add-user.sh admin admin --silent

ENTRYPOINT ["/bin/bash", "-c", "/opt/jboss/wildfly/bin/standalone.sh -Dauth_server.host=$AUTH_SERVER_HOST -Dauth_server.port=$AUTH_SERVER_PORT -b 0.0.0.0"]

