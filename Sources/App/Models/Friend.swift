//
//  Friend.swift
//  App
//
//  Created by Jussi Suojanen on 16/12/2018.
//

import FluentMySQL
import Vapor

final class Friend: Codable {
    var id: Int?
    let firstname: String
    let lastname: String
    let phonenumber: String

    init(id: Int?, firstname: String, lastname: String, phonenumber: String) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.phonenumber = phonenumber
    }
}

extension Friend: MySQLModel { }

/// Allows `Friend` to be used as a dynamic migration.
extension Friend: Migration { }

/// Allows `Friend` to be encoded to and decoded from HTTP messages.
extension Friend: Content { }

/// Allows `Friend` to be used as a dynamic parameter in route definitions.
extension Friend: Parameter { }
