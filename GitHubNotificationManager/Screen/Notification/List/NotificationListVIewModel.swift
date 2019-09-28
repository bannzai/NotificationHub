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

final public class NotificationListViewModel: ObservableObject {
    private var canceller: Set<AnyCancellable> = []
    
    @Published private var allNotifications: [Notification] = []
    @Published internal var searchWord: String = ""

    private var filteredNotifications: [Notification] {
        allNotifications.filter { $0.match(for: searchWord) }
    }
    
    internal var notifications: [Notification] {
        searchWord.isEmpty ? allNotifications : filteredNotifications
    }
}

internal extension NotificationListViewModel {
    func fetch() {
        GitHubAPI
            .request(request: NotificationsRequest())
            .catch { (_) in
                Just([NotificationElement]())
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
        .sink(receiveValue: { [weak self] (notifications) in
            self?.allNotifications += notifications
            }
        )
        .store(in: &canceller)
    }
}
