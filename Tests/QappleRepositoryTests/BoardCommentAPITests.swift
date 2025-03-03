//
//  BoardCommentAPITests.swift
//  QappleRepository
//
//  Created by Simmons on 2/13/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct BoardCommentAPITests {
    
    @Test("게시글 댓글 리스트 조회 테스트")
    func fetchList() async throws {
        let accessToken = try await TestHelper.accessToken()
        let _ = try await BoardCommentAPI.fetchList(
            boardId: 1,
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
    }
    
    @Test("게시글 댓글 생성, 좋아요 및 취소, 삭제 테스트")
    func create() async throws {
        let accessToken = try await TestHelper.accessToken()
        let create = try await BoardCommentAPI.create(
            boardId: 1,
            content: "테스트 댓글",
            server: .test,
            accessToken: accessToken
        )
        let like = try await BoardCommentAPI.like(
            commentId: create.boardCommentId,
            server: .test,
            accessToken: accessToken
        )
        #expect(like.isLiked)
        let disLike = try await BoardCommentAPI.like(
            commentId: create.boardCommentId,
            server: .test,
            accessToken: accessToken
        )
        #expect(!disLike.isLiked)
        let _ = try await BoardCommentAPI.delete(
            commentId: create.boardCommentId,
            server: .test,
            accessToken: accessToken
        )
    }
}
