//
//  AuthentificationAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubData
import Combine

public struct SignupAction: Action {
    public let githubAccessToken: String

// sourcery:inline:auto:SignupAction.AutoInitAction:
    public init(
        githubAccessToken: String
        ) {
        self.githubAccessToken = githubAccessToken
    }
// sourcery:end
}
