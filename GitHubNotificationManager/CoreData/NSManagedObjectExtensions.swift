//
//  NSManagerdObject+ClassName.swift
//  GitHubNotificationManager
//
//  Created by Yudai Hirose on 2019/10/13.
//  Copyright © 2019 bannzai. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {
    class func className() -> String {
        return String(describing: classForCoder())
    }
}

extension NSManagedObject {
    static var context: NSManagedObjectContext {
        CoreDataAccessor.shared.persistentContainer.viewContext
    }
}

extension NSManagedObject {
    class func create() -> Self {
        NSEntityDescription.insertNewObject(forEntityName: className(), into: NSManagedObject.context) as! Self
    }
}
