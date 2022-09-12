//
//  CommunitiesAPI.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 12.09.2022.
//

import Foundation

final class CommunitiesAPI {
    
    func fetchCommunities(offset: Int = 0, completion: @escaping([Community], Int)->()) {
    
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        
        urlComponents.queryItems = [
            URLQueryItem.init(name: "user_id", value: "\(Session.shared.userId)"),
            URLQueryItem.init(name: "extended", value: "1"),
            URLQueryItem.init(name: "fields", value: "members_count,status"),
            URLQueryItem.init(name: "v", value: "5.131"),
            URLQueryItem.init(name: "access_token", value: Session.shared.token),
        ]
        
        guard let url = urlComponents.url else { return }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let jsonData = data else { return }
            
            do {
                let communitiesResponse = try JSONDecoder().decode(CommunitiesResponse.self, from: jsonData)
                let communities = communitiesResponse.response.items
                let communitiesCount = communitiesResponse.response.count
                DispatchQueue.main.async {
                    completion(communities, communitiesCount)
                }
            } catch {
                print(error)
            }
            
        }.resume()
    }
}
