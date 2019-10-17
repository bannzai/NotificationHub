#! /bin/bash 
set -eu
set -o pipefail

PWD=`dirname $0`
SECRET_PATH=$PWD/../../NotificationHub/Frameworks/NotificationHubCore/Secret

cp -i $SECRET_PATH/Secret.swift.sample $SECRET_PATH/Secret.swift
