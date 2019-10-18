//
//  AuthentificationState.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public struct AuthenfiicationState: ReduxState, Codable, Equatable {
    public internal(set) var githubAccessToken: String? = nil
    public var isAuthorized: Bool { githubAccessToken != nil }
}
