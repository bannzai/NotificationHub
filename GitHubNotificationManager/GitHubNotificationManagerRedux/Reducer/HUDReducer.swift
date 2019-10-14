//
//  HUDAction.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

let hudReducer: Reducer<HUDState> = { state, action in
    var state = state
    switch action {
    case let networkAction as NetworkRequestAction:
        switch networkAction {
        case .start:
            state.current = .show
        case .finished:
            state.current = .hide
        }
    case _:
        break
    }
    return state
}
