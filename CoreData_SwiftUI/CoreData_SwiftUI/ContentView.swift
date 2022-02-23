//
//  ContentView.swift
//  CoreData_SwiftUI
//
//  Created by Nicholas Sseguya on 22/02/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems: FetchedResults<ToDoItem>
    
    @State private var newToDoItem = ""
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \ToDoItem.createdAt, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<ToDoItem>

    var body: some View {
        
        NavigationView {
            
            List {
                
                Section(header: Text("What's next?")) {
                    HStack {
                        TextField("New To Item", text: self.$newToDoItem)
                        Button(action: {
                            
                            let newItem = ToDoItem(context: viewContext)
                            
                            newItem.title = self.newToDoItem
                            newItem.createdAt = Date()

                            do {
                                try viewContext.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                            self.newToDoItem = ""
                            
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
                
                Section(header: Text("To Do's")) {
                    
                    ForEach(self.toDoItems) { toDoItem in
                        ToDoItemView(title: toDoItem.title!, createdAt: "\(toDoItem.createdAt!)")
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle("My List")
            .navigationBarItems(trailing: EditButton())
        }
        
        
        
        
        
        
        
        
        
        
        
        
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.createdAt!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.createdAt!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
    }

    private func addNewToDoItem() {
        withAnimation {
            let newItem = ToDoItem(context: viewContext)
            
            newItem.title = newToDoItem
            newItem.createdAt = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                
                print(error)
            }
            
            newToDoItem = ""
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { toDoItems[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
