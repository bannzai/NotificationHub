//
//  HUDState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

struct HUDState: ReduxState, Codable {
    enum HUDStateType: Int, Codable  {
        case show
        case hide
    }
    
    var current: HUDStateType = .hide
}
