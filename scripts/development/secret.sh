#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
SECRET_PATH=$PWD/../../NotificationHub/Frameworks/NotificationHubCore/Secret

set +e
cp -i $SECRET_PATH/Secret.swift.sample $SECRET_PATH/Secret.swift
set -e

printf "Start to replace from GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA to %s\n" $GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA $SECRET_PATH/Secret.swift

sed -i '' -e "s/GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA;$GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA;" $SECRET_PATH/Secret.swift
sed -i '' -e "s/GITHUB_CLIENT_ID/$GITHUB_CLIENT_ID/" $SECRET_PATH/Secret.swift
sed -i '' -e "s/GITHUB_CLIENT_SECRET/$GITHUB_CLIENT_SECRET/" $SECRET_PATH/Secret.swift
