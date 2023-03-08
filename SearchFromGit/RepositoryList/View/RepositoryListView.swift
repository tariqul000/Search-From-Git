//
//  ContentView.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    //  @State private var searchText = ""
    @ObservedObject var viewModel: RepositoryListViewModel

    var body: some View {
            NavigationView {
                List(viewModel.displayData) { displayData in
                    ListItemView(displayData: displayData)
                }
                .navigationTitle("Search Repositories")
                .onAppear(){
                    self.viewModel.load()
                }
            }
            .searchable(text: $viewModel.searchText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RepositoryListViewModel())
    }
}
