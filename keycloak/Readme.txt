docker build -t adesso/influx-keycloak .
docker run --name influx-keycloak jboss/keycloak

# How to update the influx realm configuration in keycloak container?
- Start a local installed keycloak server
- login and import the two json files
- change the configuration
- stop the keycloak server and restart it with
> bin/standalone.sh -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=/tmp/keycloak -Dkeycloak.migration.realmName=influx
- Open the web keycloak admin console of your target keycloak container and import the json files:
* Goto Manage/Import and import the influx-users-O.json file
* Goto Add realm and import the influx-realm.json file


# Error - Forbidden
- Have a look on the influx-keycloak containter log and you may see the error: "failed verification of token: Token is not active"
- In that case check the time values of your local environment and the docker containers
- The veirification might fail if the time gap is to big
- To reset the docker container time you can reset the time on any container. It will be promoted to all containers
- e.g. docker run --rm --privileged centos:6.7 date +%T -s "`date +"%H:%M:%S"`"


