//
//  Question+CoreDataProperties.swift
//  
//
//  Created by Alexey on 26.02.2021.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var id: Int64
    @NSManaged public var correctAnswer: String?
    @NSManaged public var answers: [String]?
    @NSManaged public var text: String?

}
