//
//  NetworkActions.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import GitHubNotificationManagerNetwork

struct ReceiveNetworkRequestError: Action {
    typealias ErrorType = RequestError
    let error: ErrorType
}

