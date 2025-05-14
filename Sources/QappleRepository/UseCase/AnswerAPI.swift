//
//  AnswerAPI.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// 답변 API
public enum AnswerAPI: Sendable {
    
    /// 작성한 답변 조회 API 입니다.
    public static func fetchListOfMine(
        threshold: Int?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> AnswerListOfMine {
        let url = try QappleAPI.Answer.listOfMine(
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 답변 삭제 API 입니다.
    public static func delete(
        answerId: Int,
        server: Server,
        accessToken: String
    ) async throws -> DeleteAnswer {
        let url = try QappleAPI.Answer.delete(answerId: Int64(answerId)).url(from: server)
        return try await NetworkService.delete(url: url, accessToken: accessToken)
    }
    
    /// 특정 질문에 대한 답변리스트를 조회하는 API입니다.
    public static func fetchListOfQuestion(
        questionId: Int,
        threshold: Int?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> AnswerListOfQuestion {
        let url = try QappleAPI.Answer.listOfQuestion(
            questionId: Int64(questionId),
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 답변 생성 API 입니다.
    public static func create(
        content: String,
        questionId: Int,
        server: Server,
        accessToken: String
    ) async throws -> CreateAnswer {
        let url = try QappleAPI.Answer.create(questionId: Int64(questionId))
            .url(from: server)
        let request = CreateAnswerRequest(answer: content)
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    public static func like(
        answerId: Int,
        server: Server,
        accessToken: String
    ) async throws -> LikeAnswer {
        let url = try QappleAPI.Answer.like(answerId: Int64(answerId))
            .url(from: server)
        let request = LikeAnswerRequest(answerId: answerId)
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
}
