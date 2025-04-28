//
//  LikeAnswer.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation

public struct LikeAnswer: Decodable, Sendable {
    public let answerId: Int
    public let isLiked: Bool
}

public struct LikeAnswerRequest: Encodable, Sendable {
    public let answerId: Int
}
