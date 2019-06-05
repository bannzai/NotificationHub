//
//  APIRequest.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public typealias Query = [String: Any]
public typealias HTTPHeader = [String: String]

public protocol APIRequest {
    associatedtype Response
    
    var query: Query? { get }
    var header: HTTPHeader? { get }
    var body: HTTPBody? { get }
}
