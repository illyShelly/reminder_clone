//
//  SelectionListView.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 09/12/2022.
//

import SwiftUI

struct SelectionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default) private var allLists: FetchedResults<Listing>
    
    
    @Binding var currentList: Listing
    
    var body: some View {
    // Permanent error -> Generic parameter 'Content' could not be inferred...
        //   ForEach(allLists, id: \.self, selection: $pickedList) { list in
        //             Text(list.wrappedName)
        //   }
            
//        Error: conforming to StringProtocol. In this case, even though the type conforms to CustomStringConvertible -> still passing a Listing.
            Picker("Select List", selection: $currentList) {
                ForEach(allLists, id: \.self) {
                    Text($0.wrappedName)
                }
            } .pickerStyle(.wheel)
    
            
            
//            List {
//                ForEach(allLists, id: \.self, selection: $pickedList) { list in
//    //                HStack {
//    //                    Image(systemName: "list.bullet.circle")
//    //                        .foregroundColor(Color.colorFromHex(list.wrappedColorCode))
//                        Text(list.wrappedName)
//                    }
    //            }
                
//            }
    }
}

struct SelectionListView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionListView(currentList: .constant(Listing()))
    }
}


//https://stackoverflow.com/questions/58908859/does-not-conform-to-string-protocol-swiftui-picker-view
