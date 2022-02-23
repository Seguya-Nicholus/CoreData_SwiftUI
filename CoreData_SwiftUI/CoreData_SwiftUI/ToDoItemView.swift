//
//  ToDoItemView.swift
//  CoreData_SwiftUI
//
//  Created by Nicholas Sseguya on 22/02/2022.
//

import SwiftUI

struct ToDoItemView: View {
    
    var title: String = ""
    var createdAt: String = ""
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(createdAt)
                    .font(.caption)
                
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(title: "Hello World", createdAt: "Today")
    }
}
