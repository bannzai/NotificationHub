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

final public class HUDPublisher {
    private let publisher = PassthroughSubject<Output, Failure>()
    
    static let shared = HUDPublisher()
    private init() {
        handle()
    }
    
    public typealias Output = HUDAppearanceType
    public typealias Failure = Never
    private var canceller: Cancellable?
    deinit {
        canceller?.cancel()
    }
    
}
private extension HUDPublisher {
    func handle() {
            canceller = sink(receiveValue: { (appearanceType) in
                HUD.shared.call(for: appearanceType)
            })
    }
}

extension HUDPublisher: Subject {
    public func send(_ value: Output) {
        publisher.send(value)
    }
    
    public func send(completion: Subscribers.Completion<Never>) {
        publisher.send(completion: completion)
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        publisher.receive(subscriber: subscriber)
    }
    
}
