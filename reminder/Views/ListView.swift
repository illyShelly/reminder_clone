//
//  ListView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 21/11/2022.
//

import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @FocusState private var nameIsFocused: Bool
    
//    Instead of using another variable to toggle modal -> bind from ContentView showingList
//    @State var closedList = false
    @Binding var showingList: Bool
    
    @State private var nameOfList: String = ""
    
    @State var selectedColor: Color = .blue
    var iconOfList: String = "list.bullet.circle"
    
    var body: some View {
        NavigationView {
            VStack {
                // Display List's 'icon', 'name'

                VStack {
                    // Image icon
                    VStack {
                        Image(systemName: "list.bullet.circle.fill")
                            .resizable()
                    }
                        .frame(width: 70, height: 70)
                        .padding(20)
                    
                    // Name of list
                    TextField(text: $nameOfList, prompt: Text("List Name")) {
                        Text(nameOfList)
                    }
                    .frame(height: 50)
                    .focused($nameIsFocused)
                    .disableAutocorrection(true)
// .textFieldStyle(.roundedBorder) // makes another light layer - 'disable' .background modifier, makes it bigger
                    .background(Color.init(uiColor: .systemGray5))
                    .multilineTextAlignment(.center)
                    .cornerRadius(5.0)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(20) // move the list up and from edges
                    .keyboardType(.default)
                }
                // 1st big rectangle
                .background(.white)
                .cornerRadius(5.0)
                .foregroundColor(selectedColor)
                
                // Display 2 lines of 'Colours' of list
                // pass the binded variable to ColorIconView
                
                ColorIconView(selectedColor: $selectedColor)
                    .cornerRadius(5.0)
                
                // Push all code on top
                Spacer()
            } // end of VS
            .padding(20)
            .background(Color.init(uiColor: .systemGray6))
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)

            
//            Toolbar on top - 'Cancel' & 'Done'
            .toolbar {
                // Cancel button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel", action: {
                        dismiss()
                    })
                }
                // Done button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done", action: {
                        createList() // create & save a new list
//                        showingList = false
                        dismiss() // Close the modal
                        
                    })
                    .disabled(nameOfList == "" ? true : false)
                    
                    // Redirect to Contentview with .sheet with above closedList = true
//                    .sheet(isPresented: $closedList,
//                           content: {
//                                ContentView()
//                    })
//                    No need the .sheet when using Binding
                }
            } // end of toolbar
            
        } // end nav

       
    }
    
    private func createList() -> Void {
// Create entity 'List' and add it into 'viewContext' used as the Environment Object
        let newList = Listing(context: viewContext)
            newList.id = UUID()
            newList.name = nameOfList
            newList.icon = iconOfList
            newList.colorCode = selectedColor.hex
        print(selectedColor.hex) // to add as default into ContentView
        
        saveList()
        
    }
    
    private func saveList() -> Void {
        do {
            try viewContext.save()
        }
        catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
  
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        //        ListView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        
        // For binding Bool showingList - need some param
        ListView(showingList: .constant(true)).environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
            
    }
}


// tell the view to dismiss itself using its presentation mode environment key. Any view can read its presentation mode using @Environment(\.presentationMode), and calling wrappedValue.dismiss() on that will cause the view to be dismissed.
            
//https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views

//                .clipShape(RoundedRectangle(cornerRadius: 5.0, style: .continuous))
