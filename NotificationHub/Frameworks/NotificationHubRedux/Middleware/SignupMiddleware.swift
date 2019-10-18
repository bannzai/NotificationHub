//
//  SignupMiddleware.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

let signupMiddleware: Middleware<ReduxState> = { dispatch, getState in
    return { next in
        return { action in
            if let action = action as? SignupAction {
                NetworkConfig.Github.accessToken = action.githubAccessToken
                UserDefaults.standard.set(action.githubAccessToken, forKey: .GitHubAccessToken)
            }
            return next(action)
        }
    }
}
