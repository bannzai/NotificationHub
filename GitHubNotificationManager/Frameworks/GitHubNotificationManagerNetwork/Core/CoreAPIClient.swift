//
//  CoreAPIClient.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public protocol CoreAPIClient {
    static func request<R: APIRequest>(request: R)
}

public typealias APIResponse = (data: Data, response: HTTPURLResponse)
public typealias RequestError = Swift.Error

internal struct BaseAPIClient {
    static func request<R: APIRequest> (request: R) -> AnyPublisher<APIResponse, RequestError> {
 fatalError()
    }
}
