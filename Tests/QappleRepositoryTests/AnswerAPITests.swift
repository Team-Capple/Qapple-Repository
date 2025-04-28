//
//  AnswerAPITests.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct AnswerAPITests {
    
    @Test("답변 생성, 내 답변 확인, 좋아요, 답변 삭제 테스트")
    func fetchListOfMine() async throws {
        let accessToken = try await TestHelper.accessToken()
        let create = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 1,
            server: .test,
            accessToken: accessToken
        )
        let _ = try await AnswerAPI.fetchListOfMine(
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
        
        let _ = try await AnswerAPI.like(
            answerId: create.answerId,
            server: .test,
            accessToken: TestHelper.accessToken()
        )
        
        let _ = try await AnswerAPI.delete(
            answerId: create.answerId,
            server: .test,
            accessToken: accessToken
        )
    }
    
    @Test("질문에 대한 답변 리스트 테스트")
    func fetchListOfQuestion() async throws {
        let _ = try await AnswerAPI.fetchListOfQuestion(
            questionId: 1,
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: TestHelper.accessToken()
        )
    }
}
