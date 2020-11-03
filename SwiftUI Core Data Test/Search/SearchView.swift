//
//  SearchView.swift
//  SwiftUI Core Data Test
//
//  Created by Chuck Hartman on 9/30/19.
//  Copyright © 2019 ForeTheGreen. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject private var dataSource = CoreDataDataSource<Attribute>()
    @State private var searchPredicate: NSPredicate? = NSPredicate(format: "name contains[c] %@", "")

    @State private var searchText = ""
    
    var body: some View {
        
        NavigationView {
            VStack {
                SearchBar(text: $searchText, predicate: $searchPredicate)
                List {
                    Section(header: Text("ATTRIBUTES CONTAINING: '\(self.searchText)'"))
                    {
                        ForEach(self.dataSource
                            .predicate(self.searchPredicate)
                            .objects) { attribute in

                            AttributeListCell(name: attribute.name,
                                              order: attribute.order)
                        }
                    }
                }
                .listStyle(GroupedListStyle())
            }
            .navigationBarTitle(Text("Search"), displayMode: .large)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
