//
//  SignUp.swift
//  QappleRepository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

public struct SignUp: Decodable, Sendable {
    public let accessToken: String?
    public let refreshToken: String?
}

public struct SignUpRequest: Encodable, Sendable {
    public let signUpToken: String
    public let email: String
    public let nickname: String
    public let deviceToken: String
}
