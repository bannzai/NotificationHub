//
//  WatchingsRequest.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

public struct WatchingsRequest: GitHubAPIRequest {
    public var path: URLPathConvertible { ["user/subscriptions"] }
    public var method: HTTPMethod { .GET }
    public typealias Response = [WatchingElement]
    public var query: Query? { ["per_page": Self.elementPerPage] }
    
    // FIXME: Want to get all element
    public static let elementPerPage = 1000

    public init() { }
}
