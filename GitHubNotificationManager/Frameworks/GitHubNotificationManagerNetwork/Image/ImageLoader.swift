//
//  ImageLoader.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import Nuke

public protocol URLConvertible {
    var url: URL { get }
}

extension URL: URLConvertible {
    public var url: URL {
        return self
    }
}

extension String: URLConvertible {
    public var url: URL {
        return URL(string: self)!
    }
}

public class ImageLoader: BindableObject {
    public var didChange = PassthroughSubject<UIImage?, Never>()
    
    func load(url: URLConvertible) {
        Nuke.ImagePipeline.shared.loadImage(with: url.url, progress: nil) { [weak self] (response, _) in
            self?.didChange.send(response?.image)
        }
    }
}
