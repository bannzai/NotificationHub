//
//  ReadNotificationsRequest.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/15.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol ReadNotificationPath {
    var readNotificationPath: URLPathConvertible { get }
}

public struct ReadNotificationsRequest: GitHubAPIRequest {
    public var path: URLPathConvertible
    public var method: HTTPMethod { .PUT }
    public typealias Response = Void
    public var body: HTTPBody? {
        .json(["last_read_at": lastReadAt])
    }
    
    private let lastReadAt: String
    
    public init(lastReadAt: String, notificationsUrl: ReadNotificationPath) {
        self.lastReadAt = lastReadAt
        self.path = notificationsUrl.readNotificationPath
    }
}

