//
//  ListView.swift
//  SearchFromGit
//
//  Created by Tariqul on 8/3/23.
//

import SwiftUI

struct ListItemView: View {
    @ObservedObject private var viewModel: RepositoryItemViewModel
    public init(displayData: RepositoryItemViewModel) {
        self.viewModel = displayData
    }
    
    var body: some View {
                
        VStack (alignment:.leading, spacing: 10) {
            Text("Repository Name: \(viewModel.repoName)")
                .font(.headline)
         }
        .frame(height: 75)
    }
}

