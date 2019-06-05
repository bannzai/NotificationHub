//
//  HTTPBody.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

public enum HTTPBody {
    case json(Any)
    case url([String: Any])
    case data(Data, type: String)
    
    func body() throws -> (data: Data?, type: String) {
        switch self {
        case .json(let object):
            let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            return (data, "application/json")
        case .url(let parameters):
            let data = parameters.urlEncode?.data(using: String.Encoding.utf8)
            return (data, "application/x-www-form-urlencoded")
        case .data(let data, let type):
            return (data, type)
        }
    }
}
