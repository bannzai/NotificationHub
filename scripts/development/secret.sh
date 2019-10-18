#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
SECRET_PATH=$PWD/../../NotificationHub/Frameworks/NotificationHubCore/Secret

set +e
cp -i $SECRET_PATH/Secret.swift.sample $SECRET_PATH/Secret.swift
set -e

printf "Start to replace from GITHUB_CLIENT_ID, GITHUB_CLIENT_SECRET, GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA to %s\n" $GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA $SECRET_PATH/Secret.swift

sed -i '' -e "s/GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA/$GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA/" $INFO_PLIST_PATH/Info.plist
sed -i '' -e "s/GITHUB_CLIENT_ID/$GITHUB_CLIENT_ID/" $INFO_PLIST_PATH/Info.plist
sed -i '' -e "s/GITHUB_CLIENT_SECRET/$GITHUB_CLIENT_SECRET/" $INFO_PLIST_PATH/Info.plist
