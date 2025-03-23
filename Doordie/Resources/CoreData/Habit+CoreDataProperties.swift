//
//  Habit+CoreDataProperties.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//
//

import UIKit
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var color: String?
    @NSManaged public var creation_date: String?
    @NSManaged public var day_part: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: UUID?
    @NSManaged public var measurement: String?
    @NSManaged public var motivations: String?
    @NSManaged public var quantity: String?
    @NSManaged public var current_quantity: String?
    @NSManaged public var regularity: String?
    @NSManaged public var title: String?

}

extension Habit : Identifiable {
    func updateHabit(newHabit: HabitModel) {
        self.title = newHabit.title
        self.motivations = newHabit.motivations
        self.color = newHabit.color
        self.icon = newHabit.icon
        self.quantity = newHabit.quantity
        self.current_quantity = newHabit.current_quantity
        self.measurement = newHabit.measurement
        self.regularity = newHabit.regularity
        self.day_part = newHabit.day_part
        
        try? managedObjectContext?.save()
    }
    
    func deleteHabit() {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
}
