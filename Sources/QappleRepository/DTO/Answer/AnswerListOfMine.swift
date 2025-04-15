//
//  AnswerListOfMine.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

public struct AnswerListOfMine: Decodable, Sendable {
    public let total: Int?
    public let size: Int
    public let content: [Content]
    public let numberOfElements: Int
    public let threshold: String
    public let hasNext: Bool
    
    public struct Content: Codable, Hashable, Sendable {
        public let questionId: Int
        public let answerId: Int
        public let writerId: Int
        public let nickname: String
        public let writerGeneration: String
        public let profileImage: String?
        public let content: String
        public let heartCount: Int
        public let writeAt: String
        public let isLiked: Bool
    }
}
