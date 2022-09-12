//
//  CommunitiesResponse.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 12.09.2022.
//

import Foundation

// MARK: - CommunitiesResponse
struct CommunitiesResponse: Codable {
    let response: CommunitiesItems
}

// MARK: - Response
struct CommunitiesItems: Codable {
    let count: Int
    let items: [Community]
}

// MARK: - Item
struct Community: Codable {
    let membersCount: Int?
    let photo100: String
    let status: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case membersCount = "members_count"
        case photo100 = "photo_100"
        case status, name
    }
}
