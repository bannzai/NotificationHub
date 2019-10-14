//
//  AuthentificationState.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

struct AuthenfiicationState: ReduxState, Codable, Equatable {
    var githubAccessToken: String? = nil
    var isAuthorized: Bool { githubAccessToken != nil }
}
