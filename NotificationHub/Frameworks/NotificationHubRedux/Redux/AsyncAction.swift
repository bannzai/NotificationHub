//
//  AsyncAction.swift
//  NotificationHub
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public protocol AsyncAction: Action {
    func async(state: ReduxState?, dispatch: @escaping DispatchFunction)
}
