#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
APP_DIR="$PWD/../../../"

cd $APP_DIR
sourcery --sources ./NotificationHub/Frameworks/NotificationHubRedux/Action/ --templates ./templates/sourcery/AutoInitAction.stencil --output ./NotificationHub/Frameworks/NotificationHubRedux/Action/

