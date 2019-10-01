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
    private var canceller: Set<AnyCancellable> = []
    @Published internal var image: UIImage = UIImage(systemName: "person")!
    
    func load(url: URLConvertible) {
        SharedImageLoader
            .shared
            .load(url: url)
            .replaceError(with: UIImage(systemName: "person")!)
            .replaceNil(with: UIImage(systemName: "person")!)
            .assign(to: \.image, on: self)
            .store(in: &canceller)
    }
}

