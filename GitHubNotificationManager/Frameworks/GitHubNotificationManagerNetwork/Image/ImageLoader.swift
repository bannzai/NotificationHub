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

public typealias ImageLoadPublisher = AnyPublisher<UIKit.UIImage?, Swift.Error>

public protocol ImageLoader {
    func load(url: URLConvertible) -> ImageLoadPublisher
}
public class SharedImageLoader: ImageLoader {
    public static let shared = SharedImageLoader()
    private init() { }
    
    public func load(url: URLConvertible) -> ImageLoadPublisher {
        ImageLoadPublisher { subscriber in
            Nuke.ImagePipeline.shared.loadImage(with: url.url, progress: nil) { (response, _) in
                _ = subscriber.receive(response?.image)
                subscriber.receive(completion: .finished)
            }
        }
    }
}
