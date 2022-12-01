//
//  ReminderView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 29/11/2022.
//

import SwiftUI

struct ReminderView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default)
    
    private var allLists: FetchedResults<Listing>
    
    // if not added value "" - need to be in the preview as ReminderView(title: "hi")
    @State var title: String = ""
    @State var notes: String = ""
    

    @FocusState private var titleFieldIsFocused: Bool
    @FocusState private var notesFieldIsFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
    //                    1st - Title
                    TextField(text: $title,
                              prompt: Text("Title")) {
                        Text(title)
                    }
                    
                        .focused($titleFieldIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
    //                    .multilineTextAlignment(.leading)
                        .keyboardType(.default)
                        .frame(height: 50)
                        .padding(.leading, 10)
                    
    //                  Divider between textfields
                        Divider().padding(.leading, 10)

//                  2nd - Notes
                    TextField("Notes", text: $notes, prompt: Text("Notes"))
                    
                        .focused($notesFieldIsFocused)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .keyboardType(.default)
                        .frame(height: 50)
                        .padding(.leading, 10)
                        .baselineOffset(4)
//
                } // VS - Textfields
                .frame(height: 100) // for both fields (100+100)
                .background(.white)
                .cornerRadius(10)
//              Push content above
                Spacer()
            }
            .padding(10) // whole box around
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
                        dismiss()
                    })
                }
            }
            // After toolbar - 1st VS has it under the TextFields, nav - cannot be
            .background(Color.init(uiColor: .systemGray6))
        } // end Nav - not visible toolbar otherwise
    } // end view
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
