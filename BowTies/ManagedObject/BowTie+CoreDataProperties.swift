//
//  BowTie+CoreDataProperties.swift
//  BowTies
//
//  Created by Anon Account on 12.06.2021.
//  Copyright © 2021 Razeware. All rights reserved.
//
//

import UIKit
import CoreData


extension BowTie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BowTie> {
        return NSFetchRequest<BowTie>(entityName: "BowTie")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var lastWorn: Date?
    @NSManaged public var name: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var rating: Double
    @NSManaged public var searchKey: String?
    @NSManaged public var timesWorn: Int32
    @NSManaged public var tintColor: UIColor?
    @NSManaged public var url: URL?
}

extension BowTie : Identifiable {
}
