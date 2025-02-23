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
        let response = try await BoardCommentAPI.fetchList(
            boardId: 1,
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 댓글 생성 테스트")
    func create() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardCommentAPI.create(
            boardId: 1,
            content: "테스트 댓글",
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 댓글 삭제 테스트")
    func delete() async throws {
        let accessToken = try await TestHelper.accessToken()
        // 댓글 생성
        let createComment = try await BoardCommentAPI.create(
            boardId: 1,
            content: "삭제할 댓글",
            server: .test,
            accessToken: accessToken
        )
        // 생성한 댓글 삭제
        let deleteComment = try await BoardCommentAPI.delete(
            commentId: createComment.boardCommentId,
            server: .test,
            accessToken: accessToken
        )
        dump(deleteComment)
    }
    
    @Test("게시글 댓글 좋아요 및 취소 테스트")
    func like() async throws {
        let accessToken = try await TestHelper.accessToken()
        // 댓글 생성
        let createComment = try await BoardCommentAPI.create(
            boardId: 1,
            content: "좋아요 테스트 댓글",
            server: .test,
            accessToken: accessToken
        )
        // 생성한 댓글에 좋아요
        let likeComment = try await BoardCommentAPI.like(
            commentId: createComment.boardCommentId,
            server: .test,
            accessToken: accessToken
        )
        dump(likeComment)
    }
}
