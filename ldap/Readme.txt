ldapadd -x -W -D "cn=admin,dc=api-demo,dc=com" -f /opt/ldap-example-users.ldif

ldapsearch -h localhost -p 389 -D cn=admin,dc=api-demo,dc=com -b dc=api-demo,dc=com -W

