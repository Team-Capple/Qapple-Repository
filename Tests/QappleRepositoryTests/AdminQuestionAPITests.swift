//
//  AdminQuestionAPITests.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Foundation
import Testing
@testable import QappleRepository


struct AdminQuestionAPITests {
    
    @Test("Admin 질문 생성 및 삭제 테스트")
    func createQuestion() async throws {
        let token = try await TestHelper.accessToken()
        let _ = try await MemberAPI.roleChange(
            role: .admin,
            server: .test,
            accessToken: token
        )
        let createQuestion = try await AdminQuestionAPI.createQuestion(
            questionStatus: .pending,
            content: "테스트 질문입니다!",
            server: .test,
            accessToken: token
        )
        let _ = try await AdminQuestionAPI.deleteQuestion(
            questionId: createQuestion.questionId,
            server: .test,
            accessToken: token
        )
    }
    
//    @Test("Admin 질문 CSV 파일 업로드 테스트")
//    func uploadQuestionsCSV() async throws {
//        let token = try await TestHelper.shared.testToken()
//        let file = Bundle.module.url(forResource: "test", withExtension: ".csv")!
//        let data = try! Data(contentsOf: file)
//        
//        let response = try await AdminQuestionAPI.createQuestionWithCSV(
//            file: data,
//            server: .test,
//            accessToken: TestHelper.shared.testToken()
//        )
//        
//        dump(response)
//    }
}
