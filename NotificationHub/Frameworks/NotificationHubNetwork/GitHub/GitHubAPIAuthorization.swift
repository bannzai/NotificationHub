//
//  GitHubAPIAuthorization.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

public struct GitHubAPIAuthorizationHeader: AuthorizationHeader {
    public var header: String { "token \(NetworkConfig.Github.accessToken!)" }
}
