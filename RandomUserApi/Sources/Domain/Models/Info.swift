//
//  Info.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 24/1/25.
//

import Foundation

struct Info: Codable {
    let seed: String?
    let results: Int
    let page: Int
    let version: String
}
