//
//  GitHub.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public struct GitHubAPI: CoreAPIClient {
    public static func request<R: APIRequest>(request: R) -> APIPublisher {
        return BaseAPIClient.request(request: request)
    }
}
