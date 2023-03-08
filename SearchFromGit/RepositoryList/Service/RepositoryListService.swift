//
//  RepositoryListService.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//
import Foundation
import Combine

protocol GitHubListServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
    func searchGitRepository(query: String) -> AnyPublisher<RepositoryListModel, Error>
}

struct RepositoryListService: GitHubListServiceProtocol {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func searchGitRepository(query: String) -> AnyPublisher<RepositoryListModel, Error> {
        let endpoint = Endpoint.searchRepository(query: query)
        return networkService
            .get(type: RepositoryListModel.self, url: endpoint.url, header: nil)
    }

}
