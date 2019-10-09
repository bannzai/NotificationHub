//
//  NotificationRequest.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol NotificationPath {
    var notificationPath: URLPathConvertible { get }
}

public struct NotificationsRequest: GitHubAPIRequest {
    public var path: URLPathConvertible
    public var method: HTTPMethod { .GET }
    public typealias Response = [NotificationElement]
    public var query: Query? { ["all": true, "page": page, "per_page": Self.elementPerPage] }
    
    public static let elementPerPage = 50
    private let page: Int
    
    public init(page: Int, notificationsUrl: NotificationPath) {
        self.page = page
        self.path = notificationsUrl.notificationPath
    }
}

