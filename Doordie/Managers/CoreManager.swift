//
//  CoreManager.swift
//  Doordie
//
//  Created by Arseniy on 31.01.2025.
//

import UIKit
import CoreData

class CoreManager {
    // MARK: - Constants
    static let shared = CoreManager()
    
    // MARK: - Lifecycle
    private init() { }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Doordie")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Public Methods
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllHabits() -> [Habit] {
        let request = Habit.fetchRequest()
        
        if let habits = try? persistentContainer.viewContext.fetch(request) {
            return habits
        }
        return []
    }
    
    func addNewHabit(_ habitModel: HabitModel) {
        let newHabit = Habit(context: persistentContainer.viewContext)
        
        newHabit.id = UUID()
        newHabit.creation_date = habitModel.creationDate
        newHabit.title = habitModel.title
        newHabit.motivations = habitModel.motivations
        newHabit.color = habitModel.color
        newHabit.icon = habitModel.icon
        newHabit.quantity = habitModel.quantity
        newHabit.current_quantity = habitModel.currentQuantity
        newHabit.measurement = habitModel.measurement
        newHabit.regularity = habitModel.regularity
        newHabit.day_part = habitModel.dayPart
        
        saveContext()
    }
}
