docker build -t adesso/api-demo-keycloak .
docker run --name api-demo-keycloak jboss/keycloak

# How to update the api-demo realm configuration in keycloak container?
- Start a local installed keycloak server
- login and import the two json files
- change the configuration
- stop the keycloak server and restart it with
> bin/standalone.sh -Dkeycloak.migration.action=export -Dkeycloak.migration.provider=dir -Dkeycloak.migration.dir=/tmp/keycloak -Dkeycloak.migration.realmName=api-demo
- Open the web keycloak admin console of your target keycloak container and import the json files:
* Goto Manage/Import and import the api-demo-users-O.json file
* Goto Add realm and import the api-demo-realm.json file


# Error - Forbidden
- Have a look on the api-demo-keycloak containter log and you may see the error: "failed verification of token: Token is not active"
- In that case check the time values of your local environment and the docker containers
- The veirification might fail if the time gap is to big
- To reset the docker container time you can reset the time on any container. It will be promoted to all containers
- e.g. docker run --rm --privileged centos:6.7 date +%T -s "`date +"%H:%M:%S"`"


