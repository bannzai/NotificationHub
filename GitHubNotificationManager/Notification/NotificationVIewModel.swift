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

final public class NotificationViewModel: BindableObject {
    struct Notification {
        struct Repository {
            let id: Int
            let name: String
            let ownerName: String
        }
        let id: String
        let reason: String
        let repository: Repository
        let url: String
    }
    var notifications: [Notification] = [] {
        didSet { didChange.send(self) }
    }
    public let didChange = PassthroughSubject<NotificationViewModel, Never>()
    
    func fetch() {
        _ = GitHubAPI.request(request: NotificationsRequest())
            .sink(receiveValue: { [weak self] (notifications) in
                self?.notifications += notifications.map {
                    Notification(
                        id: $0.id,
                        reason: $0.reason,
                        repository: NotificationViewModel.Notification.Repository(
                            id: $0.repository.id,
                            name: $0.repository.name,
                            ownerName: $0.repository.owner.login
                        ),
                        url: $0.url
                    )
                }
            })
        }
}
