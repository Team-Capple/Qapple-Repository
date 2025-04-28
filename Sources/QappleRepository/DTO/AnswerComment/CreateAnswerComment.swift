//
//  CreateAnswerComment.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation

public struct CreateAnswerComment: Decodable, Sendable {
    public let answerCommentId: Int
}

public struct CreateAnswerCommentRequest: Encodable, Sendable {
    public let answerComment: String
}
