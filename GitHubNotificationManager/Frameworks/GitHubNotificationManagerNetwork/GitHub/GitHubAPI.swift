//
//  GitHub.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public struct GitHubAPI {
    public static func request<R: GitHubAPIRequest>(request: R) -> AnyPublisher<R.Response, RequestError> where R.Response: Decodable  {
        BaseAPIClient.request(request: request)
    }
}
