//
//  ReminderView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 29/11/2022.
//

import SwiftUI

struct ReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default)
    private var allLists: FetchedResults<Listing>

    
    var body: some View {
        ForEach(allLists, id: \.self) { list in
            
            ForEach(list.remindersArr, id: \.self) { reminder in
                Text(reminder.wrappedTitle)
            }
            
        }
        
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
