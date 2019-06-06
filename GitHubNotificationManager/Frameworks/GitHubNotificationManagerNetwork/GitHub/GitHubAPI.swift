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
    public static func request<R: APIRequest> (request: R) -> AnyPublisher<R.Response, Error> where R.Response: Decodable {
        BaseAPIClient.request(request: request)
            .map { $0.data }
            .decode(type: R.Response.self, decoder: JSONDecoder())
            .handleEvents(receiveCompletion: { (completion) in
                switch completion {
                case .finished:
                    print("[INFO] Finished")
                case .failure(let error):
                    print("[ERRROR] error: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
}
