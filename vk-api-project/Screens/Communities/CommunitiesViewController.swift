//
//  CommunitiesViewController.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 10.09.2022.
//

import UIKit

class CommunitiesViewController: UIViewController {

    var viewModel = CommunitiesViewModel()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommunityCell.self, forCellReuseIdentifier: CommunityCell.reuseID)
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
        
        viewModel.fetchCommunities(bindTo: tableView)
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
        viewModel.fetchCommunities(bindTo: tableView)
        refreshControl.endRefreshing()
    }
}

// MARK: - UITableViewDataSource

extension CommunitiesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.communities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.reuseID, for: indexPath) as? CommunityCell else { return UITableViewCell() }
        
        let community = viewModel.communities[indexPath.row]
        cell.configure(community)
        
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension CommunitiesViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let maxRow = indexPaths.map { $0.last ?? 0 }.max() ?? 0
        
        if maxRow > viewModel.communities.count - 5, viewModel.isCommunitiesLoading == false, viewModel.communitiesCanLoad {
            viewModel.prefetchCommunities(bindTo: tableView)
        }
    }
}
