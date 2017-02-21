FROM osixia/openldap

ENV LDAP_DOMAIN api-demo.com
ENV LDAP_ORGANIZATION api-demo
ENV LDAP_ADMIN_PASSWORD "admin"
ENV LDAP_TLS=false

RUN apt-get update
RUN apt-get -y install vim

ADD ldap-example-users.ldif /opt



