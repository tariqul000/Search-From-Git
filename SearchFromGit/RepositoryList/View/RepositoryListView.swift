//
//  ContentView.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""

    var body: some View {
            NavigationStack {
                   Text("Searching for \(searchText)")
                       .navigationTitle("Search Repositories")
               }
           .searchable(text: $searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
