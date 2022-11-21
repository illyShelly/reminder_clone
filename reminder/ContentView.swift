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

    var body: some View {
        NavigationView {
            
            List {
                // In preview iterate with index -> need 'id' to show increased number in view 
                ForEach(allLists, id: \.self) { list in
                    
                    NavigationLink {
                        // When clicked on link -> the other screen content
                        Text(list.name ?? "Unknown")
                    } label: {
                        Text(list.name!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem {
                    Button(action: addList) {
                        Label("Add List", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Lists")
        }
    }

    private func addList() {
        withAnimation {
            let newList = Listing(context: viewContext)
            newList.name = "Hi"

            
            
            
            do {
                try viewContext.save()
            }
            catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
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
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
