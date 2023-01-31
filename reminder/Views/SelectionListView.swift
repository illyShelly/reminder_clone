//
//  SelectionListView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 09/12/2022.
//

import SwiftUI

struct SelectionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Listing.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
        animation: .default)
    private var allLists: FetchedResults<Listing>
    
    
    @Binding var currentList: Listing
        
    var body: some View {
//        To see picker as List
        List {
            Picker("", selection: $currentList) {
                ListRow()
            } .pickerStyle(.inline) // to see it as a list
        }
        .navigationTitle("List")
        .navigationBarTitleDisplayMode(.inline) //smalltext in the center

    }

}

struct SelectionListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionListView(currentList: .constant(Listing()))
            .environment(\.managedObjectContext, context)
    }
}


// Error: conforming to StringProtocol. In this case, even though the type conforms to CustomStringConvertible -> still passing a Listing.
// Solution: remove 'list 'in' -> needs Text($0.wrappedName) -> to confirm String
// Error: Generic parameter 'Content' could not be inferred?? with List & Foreach & selection
// Solution without icon: ForEach(allLists, id: \.self) { Text($0.wrappedName)
// Solution: create another view to pass 'Icon' & 'Text of List's name''

// To have visible code -> needs in Preview .environment(\.managedObjectContext, context)
// And populate the list :)

//https://stackoverflow.com/questions/58908859/does-not-conform-to-string-protocol-swiftui-picker-view

// Permanent error -> Generic parameter 'Content' could not be inferred...
//   ForEach(allLists, id: \.self, selection: $pickedList) { list in
//             Text(list.wrappedName)

