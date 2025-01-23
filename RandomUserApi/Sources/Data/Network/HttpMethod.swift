//
//  HttpMethod.swift
//  RandomUserApi
//
//  Created by David Martin Nevado on 22/1/25.
//

import Foundation

enum HttpMethod {
    case post(Data?)
    case get

    var name: String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        }
    }
}
