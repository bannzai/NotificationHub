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

final public class HUDPublisher: BindableObject {
    public let didChange = PassthroughSubject<Output, Failure>()
    var counter: Int = 0
    
    public typealias Output = HUDAppearanceType
    public typealias Failure = Never
    private var canceller: Cancellable?
    deinit {
        canceller?.cancel()
    }
    
    func show() {
       counter += 1
    }
    
    func hide() {
        counter -= 1
    }
}
