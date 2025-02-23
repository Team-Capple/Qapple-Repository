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
    
    @Test("내가 작성한 답변 리스트 테스트")
    func fetchListOfMine() async throws {
        let accessToken = try await TestHelper.accessToken()
        let _ = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 1,
            server: .test,
            accessToken: accessToken
        )
        let response = try await AnswerAPI.fetchListOfMine(
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("답변 삭제 테스트")
    func delete() async throws {
        let accessToken = try await TestHelper.accessToken()
        let createAnswer = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 1,
            server: .test,
            accessToken: accessToken
        )
        let deleteAnswer = try await AnswerAPI.delete(
            answerId: createAnswer.answerId,
            server: .test,
            accessToken: accessToken
        )
        dump(deleteAnswer)
    }
    
    @Test("질문에 대한 답변 리스트 테스트")
    func fetchListOfQuestion() async throws {
        let response = try await AnswerAPI.fetchListOfQuestion(
            questionId: 1,
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: TestHelper.accessToken()
        )
        dump(response)
    }
    
    @Test("답변 생성 테스트")
    func create() async throws {
        let response = try await AnswerAPI.create(
            content: "테스트 답변",
            questionId: 1,
            server: .test,
            accessToken: TestHelper.accessToken()
        )
        dump(response)
    }
}
