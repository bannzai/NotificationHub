//
//  CoreAPIClient.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public typealias APIResponse = (data: Data, response: HTTPURLResponse)
public typealias RequestError = NetworkError
public typealias APIPublisher = AnyPublisher<APIResponse, RequestError>

public protocol CoreAPIClient {
    static func request<R: APIRequest> (request: R) -> APIPublisher
}

public enum NetworkError: Error {
    case noResponseData
    case networkError(Swift.Error)
}
internal struct BaseAPIClient: CoreAPIClient {
    static func request<R: APIRequest> (request: R) -> APIPublisher {
        APIPublisher { subscriber in
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: request.url) { (data, response, error) in
                guard let data = data, let httpReponse = response as? HTTPURLResponse else {
                    return subscriber.receive(completion: .failure(.noResponseData))
                }
                if let error = error {
                    return subscriber.receive(completion: .failure(.networkError(error)))
                }
                
                switch subscriber.receive((data, httpReponse)) {
                case .max(let count):
                    if count == 0 { // FIXME: Not found reference for max.
                        subscriber.receive(completion: .finished)
                        session.invalidateAndCancel()
                    }
                case .unlimited:
                    break
                }
            }
            task.resume()
        }
    }
}