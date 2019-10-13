//
//  AppState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

public struct AppState: ReduxState, Codable {
    public init() { }
    var requestError: RequestError? = nil
    var watchingListState = WatchingsState()
    var hudState: HUDState = HUDState()
    var notificationPageState: NotificationPageState = NotificationPageState()
    var authentificationState: AuthenfiicationState = AuthenfiicationState()
    var title: String { notificationPageState.currentState.watching?.owner.login ?? "Notifications" }

    private enum CodingKeys: String, CodingKey {
        case watchingListState
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(watchingListState, forKey: .watchingListState)
    }
}
