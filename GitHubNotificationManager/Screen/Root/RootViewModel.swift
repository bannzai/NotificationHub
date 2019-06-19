//
//  RootViewModel.swift
//  GitHubNotificationManager
//
//  Created by Yudai.Hirose on 2019/06/07.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

final public class RootViewModel: BindableObject {
    public let didChange = PassthroughSubject<RootViewModel, Never>()

    var hudAppearanceType: HUDAppearanceType?  {
        didSet { didChange.send(self) }
    }
}
