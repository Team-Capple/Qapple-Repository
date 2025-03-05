//
//  BoardCommentList.swift
//  QappleRepository
//
//  Created by Simmons on 2/12/25.
//

import Foundation

public struct BoardCommentList: Decodable, Sendable {
    public let total: Int?
    public let size: Int
    public let content: [Content]
    public let numberOfElements: Int
    public let threshold: String
    public let hasNext: Bool
    
    public struct Content: Decodable, Sendable {
        public let boardCommentId: Int
        public let writerId: Int
        public let writerGeneration: String
        public let content: String
        public let heartCount: Int
        public let isLiked: Bool
        public let isMine: Bool
        public let isReport: Bool
        public let createdAt: String
    }
}
