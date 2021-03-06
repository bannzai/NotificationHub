//
//  CoderAction.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/17.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public struct RestoreAction: Action {
    let watching: WatchingsState

// sourcery:inline:auto:RestoreAction.AutoInitAction:
    public init(
        watching: WatchingsState
        ) {
        self.watching = watching
    }
// sourcery:end
}
