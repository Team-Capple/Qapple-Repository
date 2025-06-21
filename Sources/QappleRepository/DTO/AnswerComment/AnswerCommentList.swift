//
//  AnswerCommentList.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation

public struct AnswerCommentList: Decodable, Sendable {
    
    public let content: [Content]
    
    public struct Content: Decodable, Sendable {
        public let answerCommentId: Int
        public let writerId: Int
        public let content: String
        public let heartCount: Int
        public let isLiked: Bool
        public let isMine: Bool
        public let createdAt: String
    }
}
