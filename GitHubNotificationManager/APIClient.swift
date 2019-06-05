//
//  APIClient.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public struct APIClient<Entity>: Publisher {
    public typealias Output = Entity
    public typealias Failure = Swift.Error
    
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        
    }
}
