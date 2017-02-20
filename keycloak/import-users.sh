#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] ; then
    echo "Usage: import-users.sh {keycloak-server-hostname} {keycloak-server-port}"
    exit 1
fi

KEYCLOAK_SERVER=$1
KEYCLOAK_PORT=$2

USER_ID_JIM="c6f2c80b-3d7d-47e7-acba-48de19c786db"

getToken() {
    export TKN=$(curl \
      -d "client_id=admin-cli" \
      -d "username=admin" \
      -d "password=admin" \
      -d "grant_type=password" \
      "http://"$KEYCLOAK_SERVER":"$KEYCLOAK_PORT"/auth/realms/master/protocol/openid-connect/token" | jq -r '.access_token')
}

addUserJim() {
    export response=$(curl \
        --header "Content-Type: application/json" \
        --header "Authorization: bearer $TKN" \
        --request POST \
        --data '{
            "id" : "c6f2c80b",
            "createdTimestamp" : 1484222892279,
            "username" : "jim",
            "enabled" : true,
            "totp" : false,
            "emailVerified" : false,
            "firstName" : "jim",
            "lastName" : "foo",
            "email" : "jim@foo.com",
            "disableableCredentialTypes" : [ "password" ],
            "requiredActions" : [ "Update Password" ],
            "realmRoles" : [ "admin", "uma_authorization", "offline_access", "user" ],
            "clientRoles" : {
              "account" : [ "view-profile", "manage-account" ]
            },
            "groups" : [ ]
        }' \
        http://$KEYCLOAK_SERVER:$KEYCLOAK_PORT/auth/admin/realms/api-gw/users)

    if [ ! -z "$response" ] ; then
        echo "Error adding keycloak user: $response"
        exit 1
    fi
}

getUserIdOfJim() {
    export userId=$(curl \
        --header "Content-Type: application/json" \
        --header "Authorization: bearer $TKN" \
        --request GET \
        --data '{
            "realm" : "api-gw"
        }' \
        http://$KEYCLOAK_SERVER:$KEYCLOAK_PORT/auth/admin/realms/api-gw/users | jq -r '.[0] | .id')
    if [ -z "$userId" ] ; then
        echo "Error receiving user id"
        exit 1
    fi
}

resetPasswordOfJim() {
    export response=$(curl \
        --header "Content-Type: application/json" \
        --header "Authorization: bearer $TKN" \
        --request PUT \
        --data '{ "type": "password", "temporary": false, "value": "jim" }' \
        http://$KEYCLOAK_SERVER:$KEYCLOAK_PORT/auth/admin/realms/api-gw/users/"$userId"/reset-password)

    if [ ! -z "$response" ] ; then
        echo "Error reseting password: $response"
        exit 1
    fi
}

assignUserRoleToJim() {
    export userRoleId=$(curl \
        --header "Content-Type: application/json" \
        --header "Authorization: bearer $TKN" \
        --request GET \
        http://$KEYCLOAK_SERVER:$KEYCLOAK_PORT/auth/admin/realms/api-gw/users/"$userId"/role-mappings/realm/available | jq -r '.[] | select (.name == "user") | .id')
    if [ -z "$userRoleId" ] ; then
        echo "'user' roleId not found"
        exit 1
    fi

    export response=$(curl \
        --header "Content-Type: application/json" \
        --header "Authorization: bearer $TKN" \
        --request POST \
        --data '[{
            "clientRole" : false,
            "composite" : false,
            "containerId": "api-gw",
            "name" : "user",
            "id": "'$userRoleId'",
            "scopeParamRequired" : false
        }]' \
        http://$KEYCLOAK_SERVER:$KEYCLOAK_PORT/auth/admin/realms/api-gw/users/"$userId"/role-mappings/realm)

    if [ ! -z "$response" ] ; then
        echo "Error assigning role to Jim: $response"
        exit 1
    fi
}

# As it is not allowed to create a user with a password via Keycloak Rest API we need some complex workaround...
getToken
echo "Got Token"

addUserJim
echo "Jim added"

getUserIdOfJim
echo "Jim User Id:$userId"

assignUserRoleToJim
echo "User role assigned"
echo 0

resetPasswordOfJim
echo "Reset of Jim's password done"
exit 0


