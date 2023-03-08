//
//  RepositoryItemViewModel.swift
//  SearchFromGit
//
//  Created by Tariqul on 8/3/23.
//

import Foundation
import Combine
import UIKit

class RepositoryItemViewModel: Identifiable, ObservableObject {
    
    private let repo: Items
    private var cancellable: AnyCancellable?
    
    public init(repo: Items) {
        self.repo = repo
    }
    
    public var repoName: String {
        repo.name ?? "NA"
    }
    
    public var fullName: String {
        repo.fullName ?? "NA"
    }
    
    

    
}


