#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
INFO_PLIST_PATH=$PWD/../../GitHubNotificationManager/

cp -i $INFO_PLIST_PATH/Info.plist.sample $INFO_PLIST_PATH/Info.plist
