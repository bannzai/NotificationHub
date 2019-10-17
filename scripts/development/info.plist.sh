#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
INFO_PLIST_PATH=$PWD/../../NotificationHub/

set +e
cp -i $INFO_PLIST_PATH/Info.plist.sample $INFO_PLIST_PATH/Info.plist 
set -e

printf "Start to replace from GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA to %s for %s\n" $GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA $INFO_PLIST_PATH/Info.plist

sed -i '' -e "s/GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA/$GITHUB_NOTIFICATION_MANAGER_URL_SCHEMA/" $INFO_PLIST_PATH/Info.plist
