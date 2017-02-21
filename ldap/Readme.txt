# After the start of the container you have to manually import the ldap users to the directory!
# run client.sh
# run ldapadd -x -W -D "cn=admin,dc=api-demo,dc=com" -f /opt/ldap-example-users.ldif
#
# To verify the import you can run
# ldapsearch -h localhost -p 389 -D cn=admin,dc=api-demo,dc=com -b dc=api-demo,dc=com -W

