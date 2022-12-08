//
//  ListDetail.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 08/12/2022.
//

import SwiftUI

struct ListDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
        
    // if using StateObject -> pass from ContentView as param
    @StateObject var mylist: Listing
    
    var body: some View {
        VStack {
            // Show all reminders related to current list
            List { // not visible without populating the preview
                ForEach(mylist.remindersArr, id: \.self) { reminder in
                    Text(reminder.wrappedTitle)
                }
            }
        }
        .navigationTitle("\(mylist.wrappedName)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct ListDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = PersistenceController.shared.container.viewContext
//        ListDetail(mylist: Listing(context: context))
//        .environment(\.managedObjectContext, context)
//    }
//}
