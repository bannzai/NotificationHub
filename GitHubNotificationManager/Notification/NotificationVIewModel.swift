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
    public typealias ContentType = [GitHubNotificationManagerNetwork.Notification]
    var notifications: ContentType = [] {
        didSet { didChange.send(notifications) }
    }
    public let didChange = PassthroughSubject<ContentType, Never>()
    
    func fetch() {
        _ = GitHubAPI.request(request: NotificationsRequest())
            .sink(receiveValue: { [weak self] (notifications) in
                self?.notifications += notifications
            })
        }
}
