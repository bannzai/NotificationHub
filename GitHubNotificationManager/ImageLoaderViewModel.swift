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
    private var cancellers: [Cancellable] = []
    internal var image: UIImage?

    
    deinit {
        cancellers.forEach { $0.cancel() }
    }
    
    func load(url: URLConvertible) {
        let canceller = SharedImageLoader
            .shared
            .load(url: url)
            .handleEvents(receiveOutput: { (image) in
                self.image = image
            })
            .subscribe(didChange)
        
        cancellers.append(canceller)
    }
}
