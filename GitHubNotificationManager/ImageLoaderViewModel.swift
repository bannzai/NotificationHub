//
//  ImageLoaderViewModel.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import GitHubNotificationManagerNetwork
import UIKit.UIImage

final public class ImageLoaderViewModel: BindableObject {
    public typealias PublisherType = PassthroughSubject<UIImage?, Never>
    public var didChange = PublisherType()
    internal var image: UIImage? {
        didSet { didChange.send(image) }
    }
    
    func load(url: URLConvertible) {
        SharedImageLoader
            .shared
            .load(url: url)
            .receive(subscriber: self)
        // FIXME: Does not working for assign
//                    .assign(to: \.image, on: self)
    }
}

extension ImageLoaderViewModel: Subscriber {
    public typealias Input = UIImage?
    public typealias Failure = Never
    
    public func receive(subscription: Subscription) {
        
    }
    
    public func receive(_ input: UIImage?) -> Subscribers.Demand {
        self.image = input
        return .max(1)
    }
    
    public func receive(completion: Subscribers.Completion<Never>) {
        // NONE:
    }
    
}
