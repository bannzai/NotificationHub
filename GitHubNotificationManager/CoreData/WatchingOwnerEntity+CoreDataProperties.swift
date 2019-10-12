//
//  WatchingOwnerEntity+CoreDataProperties.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//
//

import Foundation
import CoreData


extension WatchingOwnerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchingOwnerEntity> {
        return NSFetchRequest<WatchingOwnerEntity>(entityName: "WatchingOwnerEntity")
    }

    @NSManaged public var avatarURL: String!
    @NSManaged public var name: String!
    @NSManaged public var watching: WatchingEntity!

}
