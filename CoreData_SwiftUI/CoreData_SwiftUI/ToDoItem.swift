//
//  ToDoItem.swift
//  CoreData_SwiftUI
//
//  Created by Nicholas Sseguya on 22/02/2022.
//

import Foundation
import CoreData

class ToDoItem: NSManagedObject,Identifiable {
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var title: String?
    
}

extension ToDoItem {
    static func getAllToDoItems() -> NSFetchRequest<ToDoItem> {
        
        let request: NSFetchRequest<ToDoItem> = ToDoItem.fetchRequest() as! NSFetchRequest<ToDoItem>
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
