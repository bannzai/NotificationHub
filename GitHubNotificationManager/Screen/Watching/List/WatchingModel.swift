//
//  WatchingModel.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/30.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI
import GitHubNotificationManagerNetwork

struct WatchingModelEnvironmentKey: EnvironmentKey {
    static var defaultValue: [WatchingModel] = []
}

extension EnvironmentValues {
    var watchings: [WatchingModel] {
        get { self[WatchingModelEnvironmentKey.self] }
        set { self[WatchingModelEnvironmentKey.self] = newValue }
    }
}

struct WatchingModel: Identifiable {
    struct Owner {
        let name: String
        let avatarURL: String
    }
    
    let id: Int
    let name: String
    let owner: Owner
    var isReceiveNotification: Bool

    static func create(entity: WatchingElement, isReceiveNotification: Bool) -> WatchingModel {
        WatchingModel(
            
            id: entity.id,
            name: entity.name,
            owner: WatchingModel.Owner(
                name: entity.owner.login ,
                avatarURL: entity.owner.avatarURL
            ),
            isReceiveNotification: isReceiveNotification
        )
    }
}
