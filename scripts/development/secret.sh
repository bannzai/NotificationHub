#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
SECRET_PATH=$PWD/../../GitHubNotificationManager/Frameworks/GitHubNotificationManagerCore/Secret

cp -i $SECRET_PATH/Secret.swift.sample $SECRET_PATH/Secret.swift
