SECRET_PATH?=./GitHubNotificationManager/Frameworks/GitHubNotificationManagerCore/Secret
INFO_PLIST_PATH=./GitHubNotificationManager

secret:
	cp -i $(SECRET_PATH)/Secret.swift.sample $(SECRET_PATH)/Secret.swift

infoplist:
	cp -i $(INFO_PLIST_PATH)/Info.plist.sample $(INFO_PLIST_PATH)/Info.plist
