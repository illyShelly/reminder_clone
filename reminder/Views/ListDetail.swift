//
//  ListDetail.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 08/12/2022.
//

import SwiftUI

struct ListDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // If using StateObject -> pass from ContentView as param
    @StateObject var mylist: Listing
    
    var body: some View {
        VStack {
            // Show all reminders related to current list
            List { // not visible without populating the preview
                ForEach(mylist.remindersArr, id: \.self) { reminder in
                    Text(reminder.wrappedTitle)
                }
//                .onDelete(perform: deleteReminders) // on foreach, not call on List
            }
        }
        .navigationTitle("\(mylist.wrappedName)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    //    func deleteReminders(at offset: IndexSet) -> Void {
//    func deleteReminders(offsets: IndexSet) {
//        //        viewContext.delete(mylist.remindersArr[offset.last!]) // core data has delete - deletes all
//        //        offsets.map { mylist.remindersArr[$0] }.forEach(viewContext.delete) // not working - is not mutable
//        //        mylist.remindersArr.remove(atOffsets: offset)
//        
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
    
}
//struct ListDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        let context = PersistenceController.shared.container.viewContext
//        ListDetail(mylist: Listing(context: context))
//        .environment(\.managedObjectContext, context)
//    }
//}
