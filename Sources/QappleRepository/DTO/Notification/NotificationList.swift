//
//  Notification.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Foundation


public struct NotificationList: Decodable, Sendable {
    public let total: Int?
    public let size: Int
    public let content: [Content]
    public let numberOfElements: Int
    public let threshold: String
    public let hasNext: Bool
    
    public struct Content: Decodable, Sendable {
        public let title: String
        public let subtitle: String?
        public let content: String?
        public let boardId: String?
        public let isReportedBoard: Bool?
        public let questionId: String?
        public let isResponsedQuestion: Bool?
        public let boardCommentId: String?
        public let createdAt: String
    }
}
