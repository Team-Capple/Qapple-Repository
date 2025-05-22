//
//  AnswerCommentAPI.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation

public enum AnswerCommentAPI: Sendable {
    /// 특정 답변에 대한 댓글을 조회합니다.
    public static func fetchAnswerComments(
        answerId: Int,
        server: Server,
        accessToken: String
    ) async throws -> AnswerCommentList {
        let url = try QappleAPI.AnswerComment.list(answerId: Int64(answerId))
            .url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 특정 답변에 댓글을 생성합니다.
    @discardableResult
    public static func createAnswerComment(
        answerId: Int,
        content: String,
        server: Server,
        accessToken: String
    ) async throws -> CreateAnswerComment {
        let url = try QappleAPI.AnswerComment.create(answerId: Int64(answerId))
            .url(from: server)
        let request = CreateAnswerCommentRequest(answerComment: content)
        return try await NetworkService.post(url: url, body: request, accessToken: accessToken)
    }
    
    /// 답변에 있는 특정 댓글을 삭제합니다.
    @discardableResult
    public static func deleteAnswerComment(
        answerCommentId: Int,
        server: Server,
        accessToken: String
    ) async throws -> DeleteAnswerComment {
        let url = try QappleAPI.AnswerComment.delete(answerCommentId: Int64(answerCommentId))
            .url(from: server)
        return try await NetworkService.delete(url: url, accessToken: accessToken)
    }
    
    /// 답변에 있는 특정 댓글에 좋아요 추가 or 취소 합니다.
    @discardableResult
    public static func likeAnswerComment(
        answerCommentId: Int,
        server: Server,
        accessToken: String
    ) async throws -> LikeAnswerComment {
        let url = try QappleAPI.AnswerComment.like(answerCommentId: Int64(answerCommentId))
            .url(from: server)
        let request = LikeAnswerCommentRequest(commentId: answerCommentId)
        return try await NetworkService.patch(url: url, body: request, accessToken: accessToken)
    }
}
