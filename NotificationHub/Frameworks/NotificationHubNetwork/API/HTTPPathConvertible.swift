//
//  HTTPPathConvertible.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol URLPathConvertible {
    var urlPath: String { get }
}

extension String: URLPathConvertible {
    public var urlPath: String { self }
}

extension URL: URLPathConvertible {
    public var urlPath: String { path }
}

extension Array: URLPathConvertible where Element == URLPathConvertible {
    public var urlPath: String {
        map { $0.urlPath }.reduce("") { (current, element) -> String in
            current + (current.isEmpty ? "" : "/") + element
        }
    }
}
