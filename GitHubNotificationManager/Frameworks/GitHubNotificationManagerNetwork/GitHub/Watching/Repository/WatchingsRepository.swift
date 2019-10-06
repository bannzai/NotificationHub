//
//  WatchingsRepository.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public protocol WatchingsRepository {
    func fetch() -> AnyPublisher<WatchingsRequest.Response, RequestError>
}

public struct WatchingsRepositoryImpl: WatchingsRepository {
    public init() { }
    
    public func fetch() -> AnyPublisher<WatchingsRequest.Response, RequestError> {
        return GitHubAPI
            .request(request: WatchingsRequest())
    }
}
