//
//  WatchingEntity+CoreDataClass.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/12.
//  Copyright © 2019 bannzai. All rights reserved.
//
//

import Foundation
import CoreData
import GitHubNotificationManagerNetwork

@objc(WatchingEntity)
public class WatchingEntity: NSManagedObject {
    static func create(element: WatchingElement, isReceiveNotification: Bool) -> WatchingEntity {
        print(WatchingEntity.className())
        let entity = NSEntityDescription.insertNewObject(forEntityName: WatchingEntity.className(), into: context) as! WatchingEntity
        let owner = NSEntityDescription.insertNewObject(forEntityName: WatchingOwnerEntity.className(), into: context) as! WatchingOwnerEntity
        owner.name = element.owner.login
        owner.avatarURL = element.owner.avatarURL
        entity.id = element.id
        entity.name = element.name
        entity.owner = owner
        entity.notificationsURL = element.notificationsUrl
        entity.isReceiveNotification = isReceiveNotification
        return entity
    }
}

extension WatchingEntity: Identifiable, Comparable {
    public static func < (lhs: WatchingEntity, rhs: WatchingEntity) -> Bool {
        lhs.id < rhs.id
    }
}
