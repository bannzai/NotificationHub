//
//  Canceller.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine

public protocol Canceller: class {
    var canceller: Set<AnyCancellable> { get set }
}
