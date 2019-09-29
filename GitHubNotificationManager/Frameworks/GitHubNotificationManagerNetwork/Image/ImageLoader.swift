//
//  ImageLoader.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import UIKit.UIImage
import Combine
import Nuke
import GitHubNotificationManagerCore

public typealias ImageLoadPublisher = AnyPublisher<UIImage?, ImagePipeline.Error>

public protocol ImageLoader {
    func load(url: URLConvertible) -> ImageLoadPublisher
}

public class SharedImageLoader: ImageLoader {
    public static let shared = SharedImageLoader()
    private init() { }
    
    public struct Publisher: Combine.Publisher {
        public typealias Output = UIImage?
        public typealias Failure = ImagePipeline.Error
        
        let url: URLConvertible
        public func receive<S>(subscriber: S) where S : Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            Nuke.ImagePipeline.shared.loadImage(with: url.url, progress: nil) { result in
                result.publisher
                    .map { $0.image }
                    .retry(3)
                    .subscribe(subscriber)
            }
        }
    }
    
    public func load(url: URLConvertible) -> ImageLoadPublisher {
        Publisher(url: url).eraseToAnyPublisher()
    }
}
