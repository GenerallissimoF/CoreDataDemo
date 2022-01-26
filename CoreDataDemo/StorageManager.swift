//
//  StorageManager.swift
//  CoreDataDemo
//
//  Created by Ivan Adoniev on 25.01.2022.
//
import CoreData
import Foundation

struct StorageManager {
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentContainer = {
           let container = NSPersistentContainer(name: "CoreDataDemo")
           
           container.loadPersistentStores { description, error in
             
               if let error = error {
                   fatalError("Something went wrong. We were unable to load the peristent stores. Error: \(error.localizedDescription)")
               }
           }
        
        return container
    }()
    
    var listItems: [Task] {
        
        do {
            return try persistentContainer.viewContext.fetch(NSFetchRequest<Task>(entityName: "Task"))
        } catch let error {
            print("Unable to retrieve list items \(error.localizedDescription)")
            return []
        }
    }
    
    func addTask(with name: String) {
        let listItem = NSEntityDescription.insertNewObject(forEntityName: "Task", into: persistentContainer.viewContext) as? Task
        
        listItem?.setValue(name, forKey: "name")
        
        save()
    }
    
    func removeTask(with name: String) {
            let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "%K == %@",
                                                 argumentArray: ["name", name])
            
            do {
                guard let listItem = try persistentContainer.viewContext.fetch(fetchRequest).first else {
                    return
                }
               
                persistentContainer.viewContext.delete(listItem)
                save()
            } catch let error {
                print("Unable to delete list item with name \(name). Error:", error.localizedDescription)
            }
        }
    
    
    
    private func save () {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Unable to save. Error:", error.localizedDescription)
    }
}
}
