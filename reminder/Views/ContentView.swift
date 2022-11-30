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

    @State private var showingList = false
    @State private var showingReminder = false
    
    var body: some View {
        NavigationView {
            
            List {
                // In preview iterate with index -> need 'id' to show increased number in view 
                ForEach(allLists, id: \.self) { list in
                    
                    NavigationLink {
                        // When clicked on link -> the other screen content
                        HStack {
//                            Text(list.name ?? "Unknown")
                            Text(list.wrappedName)
                            
                            // Show all reminders related to current list
                            ForEach(list.remindersArr, id: \.self) { reminder in
                                List {
                                    Text(reminder.wrappedTitle)
                                }
                            }
                        }
                    } label: {
                        // Visible on the main page - Icon & Name
                        HStack {
                            Image(systemName: "list.bullet.circle")
                            // .foregroundColor(Color.colorFromHex(list.colorCode ?? "#00C7BE"))
                                .foregroundColor(Color.colorFromHex(list.wrappedColorCode))
//                            Text(list.name!)
                            Text(list.wrappedName)
                            
                        }
                        
                    }
                }
                .onDelete(perform: deleteItems)
                
            } .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { //.bottomBar
                    Button(action: {
                        showingList.toggle()
                        print(showingList)
                        
                    }, label: {
                        Text("Add List")
                    })
                    .sheet(isPresented: $showingList, // used to pass binding value
                           content: {
                        ListView()
                    })
//                    .frame(maxWidth: .infinity, alignment: .trailing)
                } // end of ToolbarItem - List
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Button(action: {
                        showingReminder.toggle()
                        print(showingReminder)
                    }, label: {
                        Text("Add Reminder")
                    })
                    .sheet(isPresented: $showingReminder,
                           content: {
                        ReminderView()
                    })
                })
                
                
            }
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
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
