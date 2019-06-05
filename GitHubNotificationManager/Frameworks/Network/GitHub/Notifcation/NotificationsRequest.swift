//
//  NotificationRequest.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public struct NotificationsRequest: GitHubAPIRequest {
    public var path: URLPathConvertible { ["notifications"] }
    public var method: HTTPMethod { .GET }
    public typealias Response = NotificationEntity
}
