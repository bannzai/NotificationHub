//
//  GitHub.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public struct RequestError: Identifiable, Error, Equatable {
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
    
    // TODO: Use NetworkError
    public let error: Swift.Error
    public init(error: Swift.Error) {
        self.error = error
    }
    
    public var id: String { error.localizedDescription }

}

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
                    .receive(on: DispatchQueue.main)
                    .handleEvents(receiveCompletion: { (completion) in
                        switch completion {
                        case .finished:
                            Swift.print("[INFO] finished request \(self.request)")
                        case .failure(let error):
                            Swift.print("[ERROR] error request \(self.request), error: \(error)")
                        }
                    })
                    .mapError(RequestError.init(error:))
                    .subscribe(subscriber)
            } catch {
                Fail<Output, Swift.Error>(error: error)
                    .mapError(RequestError.init(error:))
                    .subscribe(subscriber)
            }
        }
    }
    
    public static func request<R: APIRequest> (request: R) -> AnyPublisher<R.Response, RequestError> where R.Response: Decodable {
        DecodedRequestPublisher(request: request).eraseToAnyPublisher()
    }
}
