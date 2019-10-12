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

extension Array where Element == WatchingEntity {
    func distinct() -> [WatchingEntity] {
        reduce(into: [WatchingEntity]()) { (result, element) in
            switch result.contains(where: { $0.owner.name == element.owner.name }) {
            case true:
                return
            case false:
                result.append(element)
            }
        }
    }
}
