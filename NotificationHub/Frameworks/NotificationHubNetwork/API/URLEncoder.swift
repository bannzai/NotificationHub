//
//  URLEncoded.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/05.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

protocol URLEncodedValue {
    var urlEncoded: String? { get }
}

extension String: URLEncodedValue {
    var urlEncoded: String? {
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
}

extension Dictionary: URLEncodedValue where Key == String {
    var urlEncoded: String? {
        reduce(String()) { string, element in
            guard let key = element.key.urlEncoded, let value = String(describing: element.value).urlEncoded else {
                return string
            }
            return string + (string.isEmpty ? "" : "&") + key + "=" + value
        }
    }
}
