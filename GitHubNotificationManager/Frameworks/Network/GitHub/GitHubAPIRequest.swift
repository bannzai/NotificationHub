//
//  GitHubAPIRequest.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol GitHubAPIRequest: APIRequest {

}

extension GitHubAPIRequest {
    public var host: String? {
        return "https://api.github.com/"
    }
    public var authorizationHeader: AuthorizationHeader? {
        return GitHubAPIAuthorizationHeader()
    }
}
