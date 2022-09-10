//
//  FriendsViewController.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 08.09.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    var viewModel = FriendsViewModel()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.reuseID)
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        return tableView
    }()
    
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
        
        viewModel.fetchFriends(bindTo: tableView)
    }
    
    //MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        tableView.pinEdgesToSuperView()
    }
    
    //MARK: - Actions
    
    @objc
    func pullToRefreshAction() {
        viewModel.fetchFriends(bindTo: tableView)
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension FriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendCell.reuseID, for: indexPath) as? FriendCell else { return UITableViewCell() }
        
        let friend = viewModel.friends[indexPath.row]
        cell.configure(friend)
        
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension FriendsViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
        if maxRow > viewModel.friends.count - 5, viewModel.isFriendsLoading == false, viewModel.friendsCanLoad {
            viewModel.prefetchFriends(bindTo: tableView)
        }
    }
}
