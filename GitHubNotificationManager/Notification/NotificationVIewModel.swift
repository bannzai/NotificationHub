//
//  NotificationVIewModel.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GitHubNotificationManagerNetwork

final public class NotificationListViewModel: BindableObject {
    struct Notification: Identifiable {
        struct Repository {
            let id: Int
            let name: String
            let ownerName: String
            let avatarURL: String
        }
        let id: String
        let reason: String
        let repository: Repository
        let url: String
    }
    var notifications: [Notification] = [] {
        didSet { didChange.send(self) }
    }
    var canceller: [Cancellable] = []
    public let didChange = PassthroughSubject<NotificationListViewModel, Never>()
    
    deinit {
        canceller.forEach { $0.cancel() }
    }
    
    func fetch() {
        let fetcher = GitHubAPI.request(request: NotificationsRequest())
             .catch { (_) in
                return Publishers.Just([NotificationElement]())
            }
            .map { notifications in
                 notifications
                    .filter { !$0.repository.repositoryPrivate }
                    .map {
                        Notification(
                            id: $0.id,
                            reason: $0.reason,
                            repository: Notification.Repository(
                                id: $0.repository.id,
                                name: $0.repository.name,
                                ownerName: $0.repository.owner.login,
                                avatarURL: $0.repository.owner.avatarURL
                            ),
                            url: $0.url
                        )
                }
        }
        
        canceller.append(
            fetcher.sink(
                receiveValue: { [weak self] (notifications) in
                    self?.notifications += notifications
            })
        )
    }
}
