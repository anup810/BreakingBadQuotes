//
//  Character.swift
//  BreakingBadQuotes
//
//  Created by Anup Saud on 2024-07-17.
//

import Foundation
struct Character:Decodable {
    let name:String
    let birthday: String
    let occupation: [String]
    let images: [URL]
    let aliases: [String]
    let status: String
    let portrayedBy: String
}
