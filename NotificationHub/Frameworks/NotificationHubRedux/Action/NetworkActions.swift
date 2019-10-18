//
//  NetworkActions.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore

public enum NetworkRequestAction: Action {
    case start
    case finished
}

public struct ReceiveNetworkRequestError: Action {
    public let error: RequestError

// sourcery:inline:auto:ReceiveNetworkRequestError.AutoInitAction:
    public init(
        error: RequestError
        ) {
        self.error = error
    }
// sourcery:end
}

