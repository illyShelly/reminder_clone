//
//  ListRow.swift
//  reminder
//
//  Created by Ilona Sellenberkova on 09/12/2022.
//

import SwiftUI

struct ListRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Listing.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Listing.name, ascending: true)],
                  animation: .default)
    private var allLists: FetchedResults<Listing>
    
    var body: some View {
        ForEach(allLists, id: \.self) { list in
            HStack {
                Image(systemName: "list.bullet.circle")
                    .foregroundColor(Color.colorFromHex(list.wrappedColorCode))
                Text(list.wrappedName)
            }
        }
        
    }
}

struct ListRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRow()
            .environment(\.managedObjectContext, context) // !
    }
}
