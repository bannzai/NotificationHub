//
//  WatchingEntity+CoreDataProperties.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//
//

import Foundation
import CoreData


extension WatchingEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WatchingEntity> {
        return NSFetchRequest<WatchingEntity>(entityName: "WatchingEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var isReceiveNotification: Bool
    @NSManaged public var name: String!
    @NSManaged public var notificationsURL: String!
    @NSManaged public var owner: WatchingOwnerEntity!

}
