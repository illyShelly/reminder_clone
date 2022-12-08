//
//  ReminderView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 29/11/2022.
//

import SwiftUI
import CoreData

struct ReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default)
    
    private var allLists: FetchedResults<Listing>
    
    @State var currentList: Listing // passing list-1st instance & call in ContentView
    
    @State var title: String = ""
    @State var notes: String = "" // if not added value empty string "" -> needs to be in the preview as: ReminderView(title: "hi")
    
    @FocusState private var titleFieldIsFocused: Bool
    @FocusState private var notesFieldIsFocused: Bool
    
    var body: some View {
        NavigationStack { // Change to Stack for choosing list, to be redirected
            VStack {
                VStack {
                    //                  1st - Title
                    List {
                        TextField(text: $title,
                                  prompt: Text("Title")) {
                            Text(title)
                        }
                          .focused($titleFieldIsFocused)
                          .textInputAutocapitalization(.never)
                          .disableAutocorrection(true)
                        //.multilineTextAlignment(.leading)
                          .keyboardType(.default)
//                        .frame(height: 50)
                        
                        
                        //                  2nd - Notes
                        TextField("Notes", text: $notes, prompt: Text("Notes"))
                            .focused($notesFieldIsFocused)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .keyboardType(.default)
                            .frame(height: 50)
                            .baselineOffset(4)
                        
                        // Choose from lists
                        // To make space within a list -> Section
                        Section {
                            NavigationLink {
                                Text("\(allLists[0].wrappedName)")
                                // Show all list to choose from
                                // ...
                                
                            } label: { // on this page
                                HStack {
                                    Text("Choose List")
                                    Spacer()
                                    Text(currentList.wrappedName)
                                }
                            }
                        }
                    } // end of list
                    
                }
                
                // VS - Textfields
                //.frame(height: 100) // for both fields (100+100)
                // .background(.white)
                // .cornerRadius(10)
            }
//            .padding(10)
            // whole box around - no need for TextFields in the List
            .font(.callout)

            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline) //smalltext in the center
            
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
                // Add button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add", action: {
                        // Save the Reminder
                        saveReminder()
                        dismiss()
                    })
                    .disabled(title == "" ? true : false)
                }
                
            } // toolbar is after 1st VS, nav - cannot be here
            .background(Color.init(uiColor: .systemGray6))
        } // end Nav - not visible toolbar otherwise
    } // end view
    
    private func saveReminder() -> Void {
        let newReminder = Reminder(context: viewContext)
        newReminder.id = UUID()
        newReminder.title = title
        newReminder.notes = notes
        newReminder.origin = currentList // no need other atrributes
//        newReminder.origin?.icon = currentList.icon
        print("new reminder -----")
        print(newReminder)
        print("currentList -----")
        print(currentList)
        print("currentList name -----")
        print(currentList.name!)
        
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
            
    }
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView(currentList: Listing.init(context: context))
        .environment(\.managedObjectContext, context)
    }
}
// Cannot be used inside Preview of Reminder
var context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
