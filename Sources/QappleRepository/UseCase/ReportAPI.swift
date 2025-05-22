//
//  ReportAPI.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Foundation

/// 신고 API입니다.
public enum ReportAPI: Sendable {
    
    /// 답변 신고 API입니다.
    @discardableResult
    public static func reportAnswer(
        answerId: Int,
        reportType: ReportType,
        server: Server,
        accessToken: String
    ) async throws -> ReportAnswer {
        let url = try QappleAPI.Reports.answer.url(from: server)
        let request = ReportAnswerRequest(
            answerId: answerId,
            reportType: "QUESTION_" + reportType.rawValue
        )
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    /// 게시글 신고 API입니다.
    @discardableResult
    public static func reportBoard(
        boardId: Int,
        reportType: ReportType,
        server: Server,
        accessToken: String
    ) async throws -> ReportBoard {
        let url = try QappleAPI.Reports.board.url(from: server)
        let request = ReportBoardRequest(
            boardId: boardId,
            boardReportType: "BOARD_" + reportType.rawValue
        )
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    /// 게시글의 달린 특정 댓글 신고 API입니다.
    @discardableResult
    public static func reportBoardComment(
        boardCommentId: Int,
        reportType: ReportType,
        server: Server,
        accessToken: String
    ) async throws -> ReportBoardComment {
        let url = try QappleAPI.Reports.boardComment.url(from: server)
        let request = ReportBoardCommentRequest(
            boardCommentId: boardCommentId,
            boardCommentReportType: "COMMENT_" + reportType.rawValue
        )
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
}
