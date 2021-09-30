//
//  UserProfile.swift
//  Assessment
//
//  Created by Vishal Patel on 2021-09-29.
//

import Foundation

struct UserProfile: Codable, Identifiable {
    var id: Int
    var avatar_url: String?
    let login: String?
    let followers: Int?
    let following: Int?
    let name: String?
    let bio: String?
}

