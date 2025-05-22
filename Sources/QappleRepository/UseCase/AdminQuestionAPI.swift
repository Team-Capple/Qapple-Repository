//
//  AdminQuestionAPI.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Foundation

/**
 Admin 계정으로 질문을 관리하는 API
 */
public enum AdminQuestionAPI: Sendable {
    /// 질문을 생성하는 API 입니다.
    @discardableResult
    public static func createQuestion(
        questionStatus: CreateQuestionRequest.QuestionStatus,
        content: String,
        server: Server,
        accessToken: String
    ) async throws -> CreateQuestion {
        let url = try QappleAPI.AdminQuestion.createQuestion
            .url(from: server)
        let request = CreateQuestionRequest(
            questionStatus: questionStatus.rawValue,
            content: content
        )
        
        return try await NetworkService.post(url: url, body: request, accessToken: accessToken)
    }
    
    /// 질문을 삭제하는 API 입니다.
    @discardableResult
    public static func deleteQuestion(
        questionId: Int,
        server: Server,
        accessToken: String
    ) async throws -> DeleteQuestion {
        let url = try QappleAPI.AdminQuestion.deleteQuestion(questionId: Int64(questionId))
            .url(from: server)
        
        return try await NetworkService.delete(url: url, accessToken: accessToken)
    }
    
//    public static func createQuestionWithCSV(
//        file: Data,
//        server: Server,
//        accessToken: String
//    ) async throws -> Int {
//        let url = try QappleAPI.AdminQuestion.uploadCSV
//            .url(from: server)
//        
//        return try await NetworkService.postCSV(url: url, csvData: file, accessToken: accessToken)
//    }
}
