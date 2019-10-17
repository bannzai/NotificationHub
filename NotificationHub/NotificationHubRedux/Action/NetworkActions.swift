//
//  NetworkActions.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubNetwork

enum NetworkRequestAction: Action {
    case start
    case finished
}

struct ReceiveNetworkRequestError: Action {
    typealias ErrorType = RequestError
    let error: ErrorType
}

