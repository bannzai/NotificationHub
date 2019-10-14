//
//  HUDState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

struct HUDState: ReduxState, Codable, Equatable {
    enum HUDStateType: Int, Codable, Equatable {
        case show
        case hide
    }
    
    var current: HUDStateType = .hide
}
