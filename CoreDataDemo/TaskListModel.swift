//
//  TaskListModel.swift
//  CoreDataDemo
//
//  Created by Ivan Adoniev on 25.01.2022.
//

import Foundation

struct TaskListModel {
   
    var listItems: [Task] {
        StorageManager.shared.listItems
    }
    
    func addTask(with name: String) {
        StorageManager.shared.addTask(with: name)
    }
    
    func removeTask(with name: String?) {
           guard let name = name else { return }
           
        StorageManager.shared.removeTask(with: name)
       }
    
}

