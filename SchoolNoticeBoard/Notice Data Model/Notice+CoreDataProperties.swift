//
//  Notice+CoreDataProperties.swift
//  SchoolNoticeBoard
//
//  Created by iOS Developer on 06/05/21.
//
//

import Foundation
import CoreData


extension Notice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notice> {
        return NSFetchRequest<Notice>(entityName: "Notice")
    }

    @NSManaged public var notice_description: String?
    @NSManaged public var notice_heading: String?
    @NSManaged public var notice_send_date_time: String?
    @NSManaged public var user_id: String?
    @NSManaged public var notice_image: String?
    @NSManaged public var teacher_name: String?
    @NSManaged public var notice_id: String?
    @NSManaged public var student_name: String?

}

extension Notice : Identifiable {

}
