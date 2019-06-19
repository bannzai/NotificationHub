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
    public let didChange = PassthroughSubject<NotificationListViewModel, Never>()
    private var canceller: [Cancellable] = []
    
    internal var notifications: [Notification] = [] {
        didSet { didChange.send(self) }
    }

    internal var searchWord: String = "" {
        didSet { didChange.send(self) }
    }
    
    deinit {
        canceller.forEach { $0.cancel() }
    }
}

internal extension NotificationListViewModel {
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
                                avatarURL: $0.repository.owner.avatarURL,
                                fullName: $0.repository.fullName
                            ),
                            subject: Notification.Subject(
                                title: $0.subject.title,
                                url: $0.subject.url
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

private extension NotificationListViewModel {
    func filtering(with searchWord: String) {
        
    }
}
