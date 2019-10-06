//
//  NotificationsRepository.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/10/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public protocol NotificationsRepository {
    func fetch(page: Int) -> AnyPublisher<NotificationsRequest.Response, RequestError>
}

public struct NotificationsRepositoryImpl: NotificationsRepository {
    private let pathType: NotificationPath
    public init(pathType: NotificationPath) {
        self.pathType = pathType
    }
    
    public func fetch(page: Int) -> AnyPublisher<NotificationsRequest.Response, RequestError> {
        return GitHubAPI
            .request(request: NotificationsRequest(page: page, notificationsUrl: pathType))
    }
}
