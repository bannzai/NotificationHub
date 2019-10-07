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

    func load(url: URLConvertible, closure: @escaping (UIImage) -> Void) {
        SharedImageLoader
            .shared
            .load(url: url)
            .replaceError(with: UIImage(systemName: "person")!)
            .replaceNil(with: UIImage(systemName: "person")!)
            .sink(receiveValue: { closure($0) })
//            .assign(to: \.image, on: self)
            .store(in: &canceller)
    }
}

