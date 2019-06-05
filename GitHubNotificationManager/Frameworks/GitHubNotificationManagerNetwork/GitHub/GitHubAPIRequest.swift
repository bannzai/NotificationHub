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
    public var host: String { "https://api.github.com/" }
    public var authorizationHeader: AuthorizationHeader? { GitHubAPIAuthorizationHeader()  }
}

extension GitHubAPIRequest where Response: Decodable {
    public func decode(data: Data) throws -> Response {
        let object = try JSONDecoder().decode(Response.self, from: data)
        return object
    }
}
