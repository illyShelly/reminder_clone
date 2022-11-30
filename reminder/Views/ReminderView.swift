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

    
    var body: some View {
        NavigationView {
            VStack {
                Text("hi")
                Spacer()
            }
            .padding(10)
            .background(Color.init(uiColor: .systemGray6))
            .navigationTitle("New Reminder")
            .navigationBarTitleDisplayMode(.inline) //small in the center
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
            }
        } // end Nav - not visible toolbar otherwise
    } // end view
}

struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
