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

struct WatchingModel: Identifiable {
    struct Owner {
        let name: String
        let avatarURL: String
    }
    
    let id: Int
    let owner: Owner

    static func create(entity: WatchingElement) -> WatchingModel {
        WatchingModel(
            id: entity.id,
            owner: WatchingModel.Owner(
                name: entity.owner.login ,
                avatarURL: entity.owner.avatarURL
            )
        )
    }
}
