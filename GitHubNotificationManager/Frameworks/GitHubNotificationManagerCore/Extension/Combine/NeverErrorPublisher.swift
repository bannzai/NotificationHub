//
//  NeverErrorPublisher.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/09/29.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
public struct NeverErrorPublisher<T>: Publisher {
    public typealias Output = T
    public typealias Failure = Never
    
    public static func error(_ any: Any) -> NeverErrorPublisher {
        NeverErrorPublisher()
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, NeverErrorPublisher.Failure == S.Failure, NeverErrorPublisher.Output == S.Input {
        subscribe(subscriber)
    }
}

