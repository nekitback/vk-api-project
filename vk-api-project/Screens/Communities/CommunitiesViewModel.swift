//
//  CommunitiesViewModel.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 13.09.2022.
//

import UIKit

final class CommunitiesViewModel {
    
    var communitiesAPI = CommunitiesAPI()
    
    var communities: [Community] = []
    
    var isCommunitiesLoading = false
    
    var communitiesCount: Int = 0
    
    var communitiesCanLoad: Bool {
        return communities.count < communitiesCount
    }
    
    func fetchCommunities(bindTo tableView: UITableView) {
        communitiesAPI.fetchCommunities(offset: 0) { communities, count in
            self.communities = communities
            self.communitiesCount = count
            tableView.reloadData()
        }
    }
    
    func prefetchCommunities(bindTo tableView: UITableView) {
        isCommunitiesLoading = true
        
        communitiesAPI.fetchCommunities(offset: communities.count) { communities, count in
            self.communities.append(contentsOf: communities)
            self.communitiesCount = count
            tableView.reloadData()
            self.isCommunitiesLoading = false
        }
    }
}
