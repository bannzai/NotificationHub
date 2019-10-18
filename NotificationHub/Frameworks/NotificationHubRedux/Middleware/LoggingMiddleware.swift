//
//  LoggingMiddleware.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/17.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public let loggingMiddleware: Middleware<ReduxState> = { dispatch, getState in
    return { next in
        return { action in
            print("[INFO] action is \(type(of: action))")
            return next(action)
        }
    }
}
