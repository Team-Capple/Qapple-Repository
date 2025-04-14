//
//  LikeAnswerComment.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation

public struct LikeAnswerComment: Decodable, Sendable {
    public let answerCommentId: Int
    public let isLiked: Bool
}

public struct LikeAnswerCommentRequest: Encodable, Sendable {
    public let commentId: Int
}
