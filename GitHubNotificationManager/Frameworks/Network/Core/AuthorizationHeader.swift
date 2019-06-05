//
//  Authorization.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol AuthorizationHeader {
    var key: String { get }
    var value: String { get }
    var header: String { get }
}

extension AuthorizationHeader {
    public var header: String {
        return "\(key): \(value)"
    }
}
