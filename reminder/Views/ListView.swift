//
//  ListView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 21/11/2022.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State private var nameOfList: String = ""
    @FocusState private var nameIsFocused: Bool
    @Environment(\.dismiss) var dismiss
    
    @State var closedList = false
    
    var iconOfList: String = "list.bullet.circle"
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .mint, .cyan, .blue, .indigo, .purple, .pink, .brown, .gray]
    @State var selectedColor: Color = .black
    
    var body: some View {
        NavigationView {
            VStack {

                // Inline Textfield for 'name' of list
                Section {
                    // Image icon
                    VStack {
                        Image(systemName: "list.bullet.circle")
                            .resizable()
    //                            .foregroundColor(selectedColor)
                            .fontWeight(.light)
                    }
                    .frame(width: 70, height: 70)
                    .padding(.bottom, 20)
                    
                    // Name of list
                    TextField(text: $nameOfList,
                              prompt: Text("List Name")) {
                        Text(nameOfList)
                    }
                        .focused($nameIsFocused)
                        .disableAutocorrection(true)
                        .textFieldStyle(.roundedBorder)
                        .multilineTextAlignment(.center)
                        .font(.title)
    //                        .keyboardType(.default)
                }
                .foregroundColor(selectedColor)
                .padding(.horizontal, 50)
                .padding(.vertical, 10)
                
                // 'colours' of list
                Grid(horizontalSpacing: 1, verticalSpacing: 20) {
                    GridRow {
                        ForEach(0..<colors.count/2) { idx in
                            Button(action: {
                                print("clicked \(colors[idx])")
                                selectedColor = colors[idx]

                            }, label: {
                                Label("", systemImage: "circle.fill")
                                    .foregroundColor(colors[idx])
    //                                    .font(.title)
                            })
                        }
                    }
                    GridRow {
                        ForEach(colors.count/2..<colors.count) { idx in
                            Button(action: {
                                print("clicked \(colors[idx])")
                                selectedColor = colors[idx]

                            }, label: {
                                Label("", systemImage: "circle.fill")
                                    .foregroundColor(colors[idx])
    //                                    .font(.title)
                            })
                        }
                    }
                    
                }.frame(height: 150)
                    .font(.title)
                
//                Section {
//
//                    HStack {
//                        ForEach(colors, id: \.self) { color in
//
//                                Button(action: {
//                                    print("clicked \(color)")
//                                    selectedColor = color
//
//                                }, label: {
//                                    Label("", systemImage: "circle.fill")
//                                        .foregroundColor(color)
//                                        .font(.title)
//                                })
//                                .padding(.horizontal, 2)
//                        }
//                    }
//
//                    .frame(width: 300, height: 150)
//                    .lineLimit(2)
//                    .background(.gray)
//                }
                
                // Push all code on top
                Spacer()
            }
            .padding(20)
            
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
//                    .sheet(isPresented: $closedList) {
//                        ContentView()
//                    }
                }
            }
            
        } // end nav
    }
    
    private func saveList() -> Void {
        let newList = Listing(context: viewContext)
            newList.name = nameOfList
                                
        do {
            try viewContext.save()
        } catch {
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
