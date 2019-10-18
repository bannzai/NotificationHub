SECRET_PATH?=./NotificationHub/Frameworks/NotificationHubCore/Secret
INFO_PLIST_PATH=./NotificationHub

setup:
	./scripts/development/info.plist.sh
	./scripts/development/secret.sh

udg:
	udg generate --output	NotificationHub/Frameworks/NotificationHubCore/Storage/UserDefaultsGenerator.generated.swift
	
