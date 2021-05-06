//
//  User+CoreDataProperties.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var password: String?
    @NSManaged public var userId: String?
    @NSManaged public var username: String?

}

extension User : Identifiable {

}
