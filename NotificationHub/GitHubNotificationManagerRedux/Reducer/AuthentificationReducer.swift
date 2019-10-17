//
//  AuthentificationReducer.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

let authentificationReducer: Reducer<AuthenfiicationState> = { state, action in
    switch action {
    case let action as SignupAction:
        var state = state
        state.githubAccessToken = action.githubAccessToken
        return state
    case _:
        return state
    }
}
