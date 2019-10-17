//
//  DeviceType.swift
//  NotificationHub
//
//  Created by Yudai.Hirose on 2019/10/06.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import SwiftUI

public enum DeviceType: String, CaseIterable, Identifiable {
    // TODO: Add cases
    case iPhoneSE = "iPhone SE"
    case iPhoneXSMax = "iPhone XS Max"
    
    public var id: String { rawValue }
    
    var preview: PreviewDevice { PreviewDevice(rawValue: rawValue) }
    var name: String { rawValue }
    
    static var previewDevices: [DeviceType] { [.iPhoneSE, .iPhoneXSMax] }
}
