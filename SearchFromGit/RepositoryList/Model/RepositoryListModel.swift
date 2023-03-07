//
//  RepositoryListModel.swift
//  SearchFromGit
//
//  Created by Tariqul Islam on 7/3/23.
//

import Foundation
struct RepositoryListModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let name, fullName: String
    let owner: Owner

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case owner
    }
}

// MARK: - Owner
struct Owner: Codable {
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
    }
}
