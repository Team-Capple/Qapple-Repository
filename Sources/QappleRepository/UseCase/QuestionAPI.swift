//
//  QuestionAPI.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Foundation

/**
 질문 관련 API
 */
public enum QuestionAPI: Sendable {
    /// 질문 목록을 불러오는 API 입니다.
    public static func fetchQuestionList(
        threshold: String?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> Question {
        let url = try QappleAPI.Question.list(
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 현재 LIVE인 질문을 불러오는 API 입니다.
    public static func fetchMainQuestion(
        server: Server,
        accessToken: String
    ) async throws -> MainQuestion {
        let url = try QappleAPI.Question.listOfMain
            .url(from: server)
        
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
}
