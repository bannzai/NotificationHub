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
import SwiftUI

@objc(WatchingEntity)
public class WatchingEntity: NSManagedObject {
    static func create(element: WatchingElement, isReceiveNotification: Bool) -> WatchingEntity {
        let entity = WatchingEntity.create()
        let owner = WatchingOwnerEntity.create()
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

extension WatchingEntity {
    var bindingReceiveNotification: Binding<Bool> {
        Binding<Bool>(
            get: { self.isReceiveNotification },
            set: { self.setReceiveNotification(value: $0) }
        )
    }
    func setReceiveNotification(value: Bool) {
        objectWillChange.send()
        isReceiveNotification = value
        do {
            try managedObjectContext?.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
