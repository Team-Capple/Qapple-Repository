//
//  SingleBoard.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Foundation

public struct SingleBoard: Decodable, Sendable {
    public let boardId: Int
    public let writerId: Int
    public let writerNickname: String
    public let writerGeneration: String
    public let content: String
    public let heartCount: Int
    public let commentCount: Int
    public let createdAt: String
    public let isMine: Bool
    public let isReported: Bool
    public let isLiked: Bool
}
