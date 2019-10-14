//
//  NotificationData.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

#if DEBUG
let debugNotification = NotificationElement(
    id: "",
    unread: false,
    subject: Subject(
        title: "Subject",
        url: "https://github.com/bannzai"
    ),
    repository: Repository(
        id: 1,
        name: "name",
        fullName: "bannzai/GitHubNotificationManager",
        repositoryPrivate: false,
        owner: Owner(
            id: 2,
            login: "bannzai",
            avatarURL: Debug.Const.avatarURL
        )
    ),
    reason: "reason",
    url: "https://github.com"
)


#endif
