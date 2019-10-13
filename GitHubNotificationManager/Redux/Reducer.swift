//
//  Reducer.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public typealias Reducer<State> = (_ state: State, _ action: Action) -> State
