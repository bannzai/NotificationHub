//
//  FuzzyFindable.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/06/19.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import NotificationHubCore
import NotificationHubData

protocol FuzzyFindable {
    func fuzzyWords() -> [String]
}

extension FuzzyFindable {
    func match(for string: String) -> Bool {
        fuzzyWords().reduce(false) { result, word in
            result || word.contains(string) // FIXME: Using any fuzzy match algorithm
        }
    }
}

extension NotificationElement: FuzzyFindable {
    func fuzzyWords() -> [String] {
        [
            repository.name,
            repository.owner.login,
            repository.owner.avatarURL,
            repository.fullName,
            reason,
            url,
            subject.title,
            subject.url
        ]
    }
}
