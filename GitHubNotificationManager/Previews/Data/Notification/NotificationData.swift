//
//  NotificationData.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

#if DEBUG
let notification = Notification(
    id: "",
    reason: "reason",
    repository: Notification.Repository(
        id: 1,
        name: "name",
        ownerName: "owner name",
        avatarURL: "d",
        fullName: "bannzai/GitHubNotificationManager"
    ),
    subject: Notification.Subject(
        title: "Subject",
        url: "https://github.com/bannzai"
    ),
    url: "https://github.com"
)


#endif
