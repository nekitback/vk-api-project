//
//  CommunityCell.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 13.09.2022.
//

import UIKit
import SDWebImage

protocol CommunitiesCellInput {
    func configure(_ model: Community)
}

class CommunityCell: UITableViewCell, CommunitiesCellInput {

    static let reuseID = "CommunityCell"
    
    var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    var groupStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    var groupMembersCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(groupStatusLabel)
        contentView.addSubview(groupMembersCountLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            groupNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            groupNameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            groupNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            groupMembersCountLabel.topAnchor.constraint(equalTo: groupNameLabel.bottomAnchor, constant: 5),
            groupMembersCountLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            groupStatusLabel.topAnchor.constraint(equalTo: groupMembersCountLabel.bottomAnchor, constant: 5),
            groupStatusLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            groupStatusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
    }
    
    //MARK: - Public
    
    func configure(_ model: Community) {
        groupNameLabel.text = model.name
        groupStatusLabel.text = model.status
        groupMembersCountLabel.text = "Количество участников: \(model.membersCount ?? 0)"
        
        let url = URL.init(string:  model.photo100)
        photoImageView.sd_setImage(with: url)
    }
    
}
