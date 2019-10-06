SECRET_PATH?=./GitHubNotificationManager/Frameworks/GitHubNotificationManagerCore/Secret
INFO_PLIST_PATH=./GitHubNotificationManager

setup:
	./scripts/development/info.plist.sh
	./scripts/development/secret.sh

udg:
	udg generate --output	GitHubNotificationManager/Extension/StdLib/Foundation/UserDefaultsGenerator.generated.swift
