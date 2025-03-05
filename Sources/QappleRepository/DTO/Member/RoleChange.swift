//
//  RoleChange.swift
//  QappleRepository
//
//  Created by Simmons on 2/12/25.
//

import Foundation

public struct RoleChange: Decodable, Sendable {
    public let accessToken: String
    public let refreshToken: String
}
