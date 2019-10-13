//
//  AsyncMiddleware.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public let asyncActionsMiddleware: Middleware<ReduxState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? AsyncAction {
                action.async(state: getState(), dispatch: dispatch)
            }
            return next(action)
        }
    }
}
