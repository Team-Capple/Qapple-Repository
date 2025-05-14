//
//  AnswerListOfQuestion.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Foundation

public struct AnswerListOfQuestion: Decodable, Sendable {
    public let total: Int
    public let size: Int
    public let content: [Content]
    public let numberOfElements: Int
    public let threshold: String
    public let hasNext: Bool
    
    public struct Content: Decodable, Sendable {
        public let answerId: Int
        public let writerId: Int
        public let profileImage: String?
        public let nickname: String
        public let writerGeneration: String
        public let content: String
        public let isMine: Bool
        public let isReported: Bool
        public let isLiked: Bool?
        public let writeAt: String
        public let commentCount: Int
        public let heartCount: Int
    }
}
