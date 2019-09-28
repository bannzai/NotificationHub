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

final public class ImageLoaderViewModel: ObservableObject {
    public typealias PublisherType = PassthroughSubject<UIImage?, Never>
    public var didChange = PublisherType()
    private var canceller: Cancellable?
    internal var image: UIImage? {
        didSet { didChange.send(image) }
    }

    deinit {
        canceller?.cancel()
    }
    
    func load(url: URLConvertible) {
        canceller = SharedImageLoader
            .shared
            .load(url: url)
            .sink { self.image = $0 }
        // FIXME: Does not working for assign
//                    .assign(to: \.image, on: self)
    }
}
