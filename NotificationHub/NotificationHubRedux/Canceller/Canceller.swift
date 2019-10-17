//
//  Canceller.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

protocol Canceller: class {
    var canceller: Set<AnyCancellable> { get set }
}
