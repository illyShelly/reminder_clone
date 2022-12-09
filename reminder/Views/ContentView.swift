//
//  ContentView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 18/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default)
        private var allLists: FetchedResults<Listing>

    @State private var showingList: Bool  = false
    @State private var showingReminder: Bool = false
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(allLists, id: \.self) { list in
                    // When clicked on -> the other screen content
                    NavigationLink {
                        
                        ListDetail(mylist: list)  // Show all reminders related to clicked list, passing its data into ListDetail View

                        
                    } label: {
                    // Icon & Name - visible on the main page
                        HStack {
                            Image(systemName: "list.bullet.circle")
                                .foregroundColor(Color.colorFromHex(list.wrappedColorCode))
                            Text(list.wrappedName)
                            
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) { //.bottomBar
                    Button(action: {
                        showingList.toggle()
                        print("\(showingList) showing list toggle")
                        
                    }, label: {
                        Text("Add List")
                    })
                    .sheet(isPresented: $showingList,
                           // used to pass binding value
                           content: {
//                        ListView() // without binding in ListView
                        ListView(showingList: $showingList)
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                } // end of ToolbarItem - List
                
                // Add Reminder Icon
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        showingReminder.toggle()
                        print(showingReminder)
                        
                    }, label: {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("New Reminder")
                        }
                    })
                    .sheet(isPresented: $showingReminder) {
                        // ReminderView()

                        ReminderView(currentList: allLists[0])
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } // end tool item
                
            })
            .navigationTitle("My Lists")
        }
    }


    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { allLists[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

//NavigationLink {
    // When clicked on link -> the other screen content
// VStack {
    // print("\(allLists[0])") // cannot use
    // let arrRemindersOfFirstList = allLists[0].remindersArr
    // let value = (arrRemindersOfFirstList.first ?? Reminder(context: context)).title // need some default item
    // Text(value ?? "default")
