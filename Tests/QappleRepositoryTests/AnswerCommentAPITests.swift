//
//  AnswerCommentAPITests.swift
//  QappleRepository
//
//  Created by 문인범 on 4/14/25.
//

import Foundation
import Testing
@testable import QappleRepository


struct AnswerCommentAPITests {
    
    @Test("특정 답변에 대한 댓글 조회 테스트")
    func fetchAnswerComments() async throws {
        let token = try await TestHelper.accessToken()
        let fetchResult = try await AnswerCommentAPI.fetchAnswerComments(
            answerId: 1,
            server: .test,
            accessToken: token
        )
        dump(fetchResult)
    }
    
    @Test("답변에 대한 댓글 생성, 좋아요, 삭제 테스트")
    func createAnswerComment() async throws {
        let token = try await TestHelper.accessToken()
        let createAnswer = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 2,
            server: .test,
            accessToken: token
        )
        
        let createAnswerComment = try await AnswerCommentAPI.createAnswerComment(
            answerId: createAnswer.answerId,
            content: "테스트",
            server: .test,
            accessToken: token
        )
        
        let likeAnswerComment = try await AnswerCommentAPI.likeAnswerComment(
            answerCommentId: createAnswerComment.answerCommentId,
            server: .test,
            accessToken: token
        )
        
        let deleteAnswerComment = try await AnswerCommentAPI.deleteAnswerComment(
            answerCommentId: createAnswerComment.answerCommentId,
            server: .test,
            accessToken: token)
        
        let _ = try await AnswerAPI.delete(
            answerId: createAnswer.answerId,
            server: .test,
            accessToken: token
        )
        
        dump(createAnswerComment)
        dump(likeAnswerComment)
        dump(deleteAnswerComment)
    }
}

