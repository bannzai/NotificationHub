//
//  GitHubAPIAuthorization.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerCore

public struct GitHubAPIAuthorizationHeader: AuthorizationHeader { 
    public var header: String {
        return "token \(Secret.GitHub.token)"
    }
}
