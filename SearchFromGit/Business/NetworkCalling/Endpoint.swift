//
//  Endpoint.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//


import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.github.com"
        components.path = "/search" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
}

extension Endpoint {
    static func searchRepository(query: String) -> Self {
        return Endpoint(path: "/repositories",
                        queryItems: [
                            URLQueryItem(name: "tariqul000",
                                         value: "\(query)")
                        ]
        )
    }
}

