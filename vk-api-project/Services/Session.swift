//
//  Session.swift
//  vk-api-project
//
//  Created by Nikita Artamonov on 10.09.2022.
//

import Foundation

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token: String = ""
    var userId: Int = 0
    var expiresIn: Int = 0
}
