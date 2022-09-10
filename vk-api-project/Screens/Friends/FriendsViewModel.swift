//
//  FriendsViewModel.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 10.09.2022.
//

import UIKit

final class FriendsViewModel {
    
    var friendsAPI = FriendsAPI()
    
    var friends: [Friend] = []
    
    var isFriendsLoading = false
    
    var friendsCount: Int = 0
    
    var friendsCanLoad: Bool {
        return friends.count < friendsCount
    }
    
    func fetchFriends(bindTo tableView: UITableView) {
        friendsAPI.fetchFriends(offset: 0) { friends, count in
            self.friends = friends
            self.friendsCount = count
            tableView.reloadData()
        }
    }
    
    func prefetchFriends(bindTo tableView: UITableView) {
        isFriendsLoading = true
        
        friendsAPI.fetchFriends(offset: friends.count) { friends, count in
            self.friends.append(contentsOf: friends)
            self.friendsCount = count
            tableView.reloadData()
            self.isFriendsLoading = false
        }
    }
}

