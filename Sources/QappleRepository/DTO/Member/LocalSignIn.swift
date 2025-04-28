//
//  LocalSignIn.swift
//  QappleRepository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

public struct LocalSignIn: Decodable, Sendable {
    public let accessToken: String?
    public let refreshToken: String
}
