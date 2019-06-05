SECRET_PATH?=./GitHubNotificationManager/Frameworks/Core/Secret/

secret:
	cp $(SECRET_PATH)GitHubNotificationManager/Secret/Secret.swift.sample $(SECRET_PATH)/GitHubNotificationManager/Secret/Secret.swift
