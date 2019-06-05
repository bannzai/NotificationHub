//
//  URLConvertible.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol URLConvertible {
    var url: URL { get }
}

extension URL: URLConvertible {
    public var url: URL {
        return self
    }
}

extension String: URLConvertible {
    public var url: URL {
        return URL(string: self)!
    }
}
