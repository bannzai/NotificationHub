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
    public var urlPath: String {
        return self
    }
}

extension URL: URLPathConvertible {
    public var urlPath: String {
        return path
    }
}

extension Array: URLPathConvertible where Element == URLPathConvertible {
    public var urlPath: String {
        return map { $0.urlPath }.reduce("") { (current, element) -> String in
            return current + (current.isEmpty ? "" : "/") + element
        }
    }
}
