//
//  NotificationData.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

#if DEBUG
let notification = NotificationListViewModel.Notification(
    id: "",
    reason: "reason",
    repository: NotificationListViewModel.Notification.Repository(
        id: 1,
        name: "name",
        ownerName: "owner name",
        avatarURL: "d",
        fullName: "bannzai/GitHubNotificationManager"
    ),
    subject: NotificationListViewModel.Notification.Subject(title: "Subject"),
    url: "https://github.com"
)


#endif
