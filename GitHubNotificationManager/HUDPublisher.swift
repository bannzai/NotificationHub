//
//  HUDPublishser.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final public class HUDPublisher: Subject {
    public func send(_ value: HUDCounterType) {
        
    }
    
    public func send(completion: Subscribers.Completion<Never>) {
        fatalError()
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        fatalError("I don't know when call this function")
    }
    
    static let shared = HUDPublisher()
    private init() { }
    
    public typealias Output = HUDCounterType
    public typealias Failure = Never
    
    
}
