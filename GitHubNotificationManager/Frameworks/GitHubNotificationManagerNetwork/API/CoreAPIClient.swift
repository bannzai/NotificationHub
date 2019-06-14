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


public enum NetworkError: Error {
    case noResponseData
    case networkError(Swift.Error)
    case makeURLRequestFaield(Swift.Error)
}

internal struct BaseAPIClient {
    static func request<R: APIRequest> (request: R) -> APIPublisher {
        APIPublisher { subscriber in
            let session = URLSession(configuration: .default)
            
            let urlRequest: URLRequest
            do {
                urlRequest = try request.urlRequest() as URLRequest
            } catch {
                return subscriber.receive(completion: .failure(.makeURLRequestFaield(error)))
            }
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                DispatchQueue.main.async { // FIXME: How to use receive(on: DispatchQueue.main)
                    if let error = error {
                        return subscriber.receive(completion: .failure(.networkError(error)))
                    }
                    guard let data = data, let httpReponse = response as? HTTPURLResponse else {
                        return subscriber.receive(completion: .failure(.noResponseData))
                    }
                    
                    _ = subscriber.receive((data, httpReponse))
                    subscriber.receive(completion: .finished)
                    session.invalidateAndCancel()
                }
            }
            task.resume()
        }
    }
    
}
