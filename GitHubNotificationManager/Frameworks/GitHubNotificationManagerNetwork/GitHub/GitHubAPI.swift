//
//  GitHub.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

// TODO: Use NetworkError
public typealias RequestError = Swift.Error

public enum NetworkError: Error {
    case noResponseData
    case networkError(Swift.Error)
    case makeURLRequestFaield(Swift.Error)
}


public struct GitHubAPI {
    internal struct DecodedRequestPublisher<Request: APIRequest>: Publisher where Request.Response: Decodable {
        typealias Output = Request.Response
        typealias Failure = RequestError
        
        let request: Request
        
        func receive<S>(subscriber: S) where S : Subscriber, DecodedRequestPublisher.Failure == S.Failure, DecodedRequestPublisher.Output == S.Input {
            do {
                URLSession.shared.dataTaskPublisher(for: try request.urlRequest())
                    .map { $0.data }
                    .decode(type: Output.self, decoder: JSONDecoder())
//                    .print()
                    .receive(on: DispatchQueue.main)
                    .subscribe(subscriber)
            } catch {
                Fail<Output, Swift.Error>(error: error)
                    .subscribe(subscriber)
            }
        }
    }
    
    public static func request<R: APIRequest> (request: R) -> AnyPublisher<R.Response, RequestError> where R.Response: Decodable {
        DecodedRequestPublisher(request: request).eraseToAnyPublisher()
    }
}
