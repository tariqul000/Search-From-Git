//
//  RepositoryListService.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

import Foundation
import Combine
import Network

protocol RepositoryListServiceProtocol {
    var networkService: NetworkServiceProtocol { get }
    func searchRepository(query: String) -> AnyPublisher<Response, Error>
}

struct RepositoryListService: RepositoryListServiceProtocol {
    var networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func searchRepository(query: String) -> AnyPublisher<Response, Error> {
        let endpoint = Endpoint.searchRepository(query: query)
        return networkService
            .get(type: Response.self, url: endpoint.url, header: nil)
    }

}
