//
//  RepositoryListViewModel.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

import Foundation
import Combine

class RepositoryListViewModel: ObservableObject {
    @Published public var searchText = ""
    @Published public var displayData: [RepositoryItemViewModel] = []
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    private var repositoryService: GitHubListServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repositoryService: GitHubListServiceProtocol = RepositoryListService()) {
        self.repositoryService = repositoryService
        _ = NetworkMonitor.shared
        bindSearch()
    }
    
    private func bindSearch() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { (str) in
                let text = str.trimmingCharacters(in:.whitespacesAndNewlines)
                guard text.count > 0 else{
                    return
                }
                self.fetchData(string: text)
            }.store(in: &cancellables)
    }
    
    public func load() {
        self.fetchData(string: "tariqul000")
    }
    
    private func fetchData(string: String) {
        repositoryService.searchGitRepository(query: string)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self.displayData = []
                case .finished: break
                }
            } receiveValue: { [weak self] repo in
                self?.displayData = repo.items.map { RepositoryItemViewModel(repo: $0)}
                print("Result = \(repo.items.count)")
            }
            .store(in: &cancellables)
    }
}
