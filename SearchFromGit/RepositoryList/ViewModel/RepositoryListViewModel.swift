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
    @Published public var displayData: [RepositoryListViewModel] = []
    
    private var searchCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    private var repositoryService: RepositoryListServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(repositoryService: RepositoryListServiceProtocol = RepositoryListService()) {
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
        self.fetchData(string: "yougov ios demo")
    }
    
    private func fetchData(string: String) {
        repositoryService.searchRepository(query: string)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                    self.displayData = []
                case .finished: break
                }
            } receiveValue: { [weak self] repo in
                
                self?.displayData = repo.items.map { RepositoryListViewModel(repo: $0)}
                print("Result count = \(repo.items.count)")
            }
            .store(in: &cancellables)
    }
}
