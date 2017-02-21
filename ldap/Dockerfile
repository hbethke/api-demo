FROM osixia/openldap

ENV LDAP_DOMAIN api-demo.com
ENV LDAP_ORGANIZATION api-demo
ENV LDAP_ADMIN_PASSWORD "admin"
ENV LDAP_TLS=false

#ADD example.ldif /opt
ADD ldap-example-users.ldif /opt

RUN apt-get update
RUN apt-get -y install vim

#RUN ldapadd -x -W -D "cn=admin,dc=api-demo,dc=com" -f /opt/example.ldif



