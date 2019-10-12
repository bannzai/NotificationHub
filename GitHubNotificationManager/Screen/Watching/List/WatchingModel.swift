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

struct WatchingModel: Identifiable, Equatable, Comparable, Hashable {
    struct Owner: Equatable {
        let name: String
        let avatarURL: String
    }
    
    struct WatchingId: Identifiable, Equatable, Hashable {
        let id: Int
    }
    
    static func < (lhs: WatchingModel, rhs: WatchingModel) -> Bool {
        lhs.id.id < rhs.id.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    let id: WatchingId
    let name: String
    let owner: Owner
    let notificationsURL: String
    var isReceiveNotification: Bool

    static func create(entity: WatchingElement, isReceiveNotification: Bool) -> WatchingModel {
        WatchingModel(
            id: .init(id: entity.id),
            name: entity.name,
            owner: WatchingModel.Owner(
                name: entity.owner.login ,
                avatarURL: entity.owner.avatarURL
            ),
            notificationsURL: entity.notificationsUrl,
            isReceiveNotification: isReceiveNotification
        )
    }
}

extension Array where Element == WatchingModel {
    func distinct() -> [WatchingModel] {
        reduce(into: [WatchingModel]()) { (result, element) in
            switch result.contains(where: { $0.owner.name == element.owner.name }) {
            case true:
                return
            case false:
                result.append(element)
            }
        }
    }
}
