SECRET_PATH?=./GitHubNotificationManager/Frameworks/GitHubNotificationManagerCore/Secret

secret:
	cp -i $(SECRET_PATH)/Secret.swift.sample $(SECRET_PATH)/Secret.swift
