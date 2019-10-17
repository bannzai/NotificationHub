//
//  StateExtension.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

func appState(_ state: ReduxState?) -> AppState {
    state as! AppState
}

