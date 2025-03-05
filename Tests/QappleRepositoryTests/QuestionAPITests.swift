//
//  QuestionAPITests.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Testing
import Foundation
@testable import QappleRepository


struct QuestionAPITests {
    
    @Test("질문 리스트 조회 테스트")
    func fetchQuestions() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await QuestionAPI.fetchQuestionList(
            threshold: nil,
            pageSize: 25,
            server: .test,
            accessToken: accessToken
        )
        
        if response.hasNext {
            let pagination = try await QuestionAPI.fetchQuestionList(
                threshold: response.threshold,
                pageSize: 25,
                server: .test,
                accessToken: accessToken
            )
            
            #expect(response.content.first!.questionId != pagination.content.first!.questionId)
        }
    }
    
    @Test("메인 질문 조회 테스트")
    func fetchMainQuestion() async throws {
        let _ = try await QuestionAPI.fetchMainQuestion(
            server: .test,
            accessToken: TestHelper.accessToken()
        )
    }
}
