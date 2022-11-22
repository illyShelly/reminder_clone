//
//  ListView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 21/11/2022.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @FocusState private var nameIsFocused: Bool
    
    @State var closedList = false
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
//                            .fontWeight(.semibold)
                    }
                    .focused($nameIsFocused)
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(20)
                    // .keyboardType(.default)
                }
                .background(.white)
                .foregroundColor(selectedColor)
                .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                
                // Display 2 lines of 'Colours' of list
                // pass the binded variable to ColorIconView
                ColorIconView(selectedColor: $selectedColor)
                
                // Push all code on top
                Spacer()
            } // end of VS
            .padding(20)
            .navigationTitle("New List")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(red: 0.949, green: 0.946, blue: 0.966))

            
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
                        saveList() // create & save a new list
                        dismiss() // Close the modal
                        
                        // With .sheet use this:
//                       closedList = true
                    })
                    .disabled(nameOfList == "" ? true : false)
                    
                    // Redirect to Contentview with .sheet with above closedList = true
                    .sheet(isPresented: $closedList,
                           content: {
                                ContentView()
                    })
                }
            } // end of toolbar
            
        } // end nav

       
    }
    
//    func convertColor() -> String {
//      return //
//    }
    
    private func saveList() -> Void {
        let newList = Listing(context: viewContext)
            newList.name = nameOfList
            newList.icon = iconOfList
                                
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
        ListView()
    }
}


// tell the view to dismiss itself using its presentation mode environment key. Any view can read its presentation mode using @Environment(\.presentationMode), and calling wrappedValue.dismiss() on that will cause the view to be dismissed.
            
//https://www.hackingwithswift.com/books/ios-swiftui/showing-and-hiding-views
