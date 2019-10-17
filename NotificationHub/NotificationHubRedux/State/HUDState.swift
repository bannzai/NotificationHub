//
//  HUDState.swift
//  NotificationHub
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
    
    var last: HUDStateType = .hide {
        didSet {
            switch last {
            case .show:
                counter += 1
            case .hide:
                counter -= 1
            }
        }
    }
    private var counter: Int = 0
    var current: HUDStateType { counter == 0 ? .hide : .show }
}
