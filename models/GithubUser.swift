//
//  GithubUser.swift
//  MiniGithubApp
//
//  Created by Josue Lubaki on 2024-03-23.
//

import Foundation

struct GithubUser : Codable {
    let login : String
    let avatarUrl : String
    let bio : String
}
