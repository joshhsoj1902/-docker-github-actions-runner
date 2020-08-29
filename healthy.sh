#!/bin/sh

repo_path="https://github.com"
api_query=""

# https://developer.github.com/v3/actions/self-hosted-runners/
if [ "$ORG_RUNNER" = "false" ]; then
    api_path="https://api.github.com/repos"
    api_query=`echo $REPO_URL | sed  "s|$repo_path|$api_path|g"`"/actions/runners"
else
GET /orgs/:org/actions/runners
    api_path="https://api.github.com/orgs"
    api_query=$api_path"/"$ORG_NAME"/actions/runners"
fi

status=`curl -s -H "Authorization: token ${ACCESS_TOKEN}" ${api_query} | jq '.runners[] | select(.name=="'$HOSTNAME'") | .status'`

if [ "$status" = "online" ]; then
    exit 0
fi

exit 1
