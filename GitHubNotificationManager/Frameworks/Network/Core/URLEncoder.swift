//
//  URLEncoded.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

protocol URLEncoder {
    var urlEncode: String? { get }
}

extension String: URLEncoder {
    var urlEncode: String? {
        return addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
}

extension Dictionary where Key == String {
    var urlEncode: String? {
        return reduce(String()) { string, element in
            guard let key = element.key.urlEncode, let value = String(describing: element.value).urlEncode else {
                return string
            }
            return string + (string.isEmpty ? "" : "&") + key + "=" + value
        }
    }
}
