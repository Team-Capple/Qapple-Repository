//
//  ReportTests.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct ReportTests {
    
    @Test("답변 신고 테스트")
    func reportAnswer() async throws {
        let accessToken = try await TestHelper.accessToken()
        let createAnswer = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 1,
            server: .test,
            accessToken: accessToken
        )
        let _ = try await ReportAPI.reportAnswer(
            answerId: createAnswer.answerId,
            reportType: .ABUSIVE_LANGUAGE_AND_DISPARAGEMENT,
            server: .test,
            accessToken: accessToken
        )
    }
    
    @Test("게시글 신고 테스트")
    func reportBoard() async throws {
        let accessToken = try await TestHelper.accessToken()
        let createBoard = try await BoardAPI.create(
            content: "테스트 게시글",
            boardType: .freeBoard,
            server: .test,
            accessToken: accessToken
        )
        let _ = try await ReportAPI.reportBoard(
            boardId: createBoard.boardId,
            reportType: .COMMERCIAL_ADVERTISING_AND_SALES,
            server: .test,
            accessToken: accessToken
        )
    }
    
    @Test("게시글 댓글 신고 테스트")
    func reportBoardComment() async throws {
        let accessToken = try await TestHelper.accessToken()
        let _ = try await BoardCommentAPI.create(
            boardId: 1,
            content: "테스트 댓글",
            server: .test,
            accessToken: accessToken
        )
        let _ = try await ReportAPI.reportBoardComment(
            boardCommentId: 1,
            reportType: .DISTRIBUTION_OF_ILLEGAL_PHOTOGRAPHS,
            server: .test,
            accessToken: accessToken
        )
    }
}
