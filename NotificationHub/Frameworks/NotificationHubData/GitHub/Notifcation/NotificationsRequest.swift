//
//  NotificationRequest.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

public protocol NotificationPath {
    var notificationPath: URLPathConvertible { get }
}

public struct NotificationsRequest: GitHubAPIRequest {
    public typealias Response = [NotificationElement]
    
    public var path: URLPathConvertible
    public var method: HTTPMethod { .GET }
    private let isOnlyNotUnread = true
    public var query: Query? { ["all": isOnlyNotUnread, "page": page, "per_page": Self.elementPerPage] }

    public static let elementPerPage = 50
    private let page: Int
    
    public init(page: Int, notificationsUrl: NotificationPath) {
        self.page = page
        self.path = notificationsUrl.notificationPath
    }
}

