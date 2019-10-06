//
//  FuzzyFindable.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/19.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation

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
