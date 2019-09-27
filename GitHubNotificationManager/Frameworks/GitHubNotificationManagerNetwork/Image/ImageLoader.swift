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

public typealias ImageLoadPublisher = AnyPublisher<UIImage, Never>

public protocol ImageLoader {
    func load(url: URLConvertible) -> ImageLoadPublisher
}

public struct NeverErrorPublisher<T>: Publisher {
    public typealias Output = T
    public typealias Failure = Never
    
    public static func just(_ any: Any) -> NeverErrorPublisher {
        NeverErrorPublisher()
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, NeverErrorPublisher.Failure == S.Failure, NeverErrorPublisher.Output == S.Input {
        subscribe(subscriber)
    }
}

public class SharedImageLoader: ImageLoader {
    public static let shared = SharedImageLoader()
    private init() { }
    
    public struct Publisher: Combine.Publisher {
        public typealias Output = UIImage
        public typealias Failure = Never
        
        let url: URLConvertible
        
        public func receive<S>(subscriber: S) where S : Subscriber, Publisher.Failure == S.Failure, Publisher.Output == S.Input {
            Nuke.ImagePipeline.shared.loadImage(with: url.url, progress: nil) { result in
                result.publisher
                    .map { $0.image }
                    .retry(3)
                    .catch(NeverErrorPublisher.just)
                    .subscribe(subscriber)
            }
        }
    }
    
    public func load(url: URLConvertible) -> ImageLoadPublisher {
        Publisher(url: url).eraseToAnyPublisher()
    }
}
