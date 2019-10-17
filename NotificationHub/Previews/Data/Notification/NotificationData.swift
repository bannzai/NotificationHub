//
//  NotificationData.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubNetwork

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
        fullName: "bannzai/NotificationHub",
        repositoryPrivate: false,
        owner: Owner(
            id: 2,
            login: "bannzai",
            avatarURL: Debug.Const.avatarURL
        )
    ),
    reason: "reason",
    url: "https://github.com",
    updatedAt: "2014-11-07T22:01:45Z"
)


#endif
