//
//  RepositoryListModel.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

struct RepositoryListModel: Codable {
    let items: [Items]
}

struct Items: Codable, Identifiable {
    var id: Int
    let name, fullName: String?

}

