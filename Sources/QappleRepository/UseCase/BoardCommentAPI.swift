//
//  BoardCommentAPI.swift
//  QappleRepository
//
//  Created by Simmons on 2/12/25.
//

import Foundation

public enum BoardCommentAPI {
    
    /// 게시글 댓글 조회 API입니다.
    public static func fetchList(
        boardId: Int,
        threshold: Int?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> BoardCommentList {
        let url = try QappleAPI.BoardComment.list(
            boardId: Int64(boardId),
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        
        return try await NetworkService.get(
            url: url,
            accessToken: accessToken
        )
    }
    
    /// 게시글 댓글 생성 API입니다.
    @discardableResult
    public static func create(
        boardId: Int,
        content: String,
        server: Server,
        accessToken: String
    ) async throws -> CreateBoardComment {
        let url = try QappleAPI.BoardComment.create(
            boardId: Int64(boardId)
        ).url(from: server)
        let request = CreateBoardCommentRequest(
            comment: content
        )
        
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    /// 게시글 댓글 삭제 API입니다.
    @discardableResult
    public static func delete(
        commentId: Int,
        server: Server,
        accessToken: String
    ) async throws -> DeleteBoardComment {
        let url = try QappleAPI.BoardComment.delete(
            commentId: Int64(commentId)
        ).url(from: server)
        
        return try await NetworkService.delete(
            url: url,
            accessToken: accessToken
        )
    }
    
    /// 게시글 댓글 좋아요 및 취소 API입니다.
    @discardableResult
    public static func like(
        commentId: Int,
        server: Server,
        accessToken: String
    ) async throws -> LikeBoardComment {
        let url = try QappleAPI.BoardComment.like(
            commentId: Int64(commentId)
        ).url(from: server)
        let request = LikeBoardCommentRequest(
            commentId: commentId
        )
        
        return try await NetworkService.patch(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
}
