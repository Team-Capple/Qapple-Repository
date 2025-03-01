//
//  RepositoryError.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// Repository에서 발생할 수 있는 에러를 정의합니다.
public enum RepositoryError: Error, Sendable {
    
    /// 유효하지 않은 SecretKey 에러
    case invalidSecretKey(String)
    
    /// 기본 URL 에러
    case invalidBaseUrl(String)
    
    /// URLReuqest 함수 호출에 실패했습니다.
    case urlRequestFailure(urlString: String)
    
    /// 유효하지 않은 Response입니다.
    case invalidResponse(urlString: String, statusCode: Int, message: String)
    
    /// 인증에 실패했습니다.(403 에러)
    case authenticationFailed
    
    /// Decoding에 실패했습니다.
    case decodingFailure(type: Decodable.Type)
    
    /// 실패 Response
    struct FailedResponse: Decodable {
        let message: String
    }
}

// MARK: - LocalizedError

extension RepositoryError: LocalizedError {
    
    /// 에러 메시지
    public var errorDescription: String? {
        switch self {
        case let .invalidSecretKey(string):
            NSLocalizedString("\(string) 설정 오류", comment: "invalidSecretKey")
        case .invalidBaseUrl:
            NSLocalizedString("BaseURL 설정 오류", comment: "invalidBaseUrl")
        case .urlRequestFailure:
            NSLocalizedString("네트워크 요청 실패", comment: "urlRequestFailure")
        case let .invalidResponse(_, statusCode, message):
            NSLocalizedString("잘못된 네트워크 응답: \(statusCode) + \(message)", comment: "invalidResponse")
        case .authenticationFailed:
            NSLocalizedString("액세스 토큰 만료: 403", comment: "authenticationFailed")
        case let .decodingFailure(type):
            NSLocalizedString("디코딩 실패: \(type)", comment: "decodingFailure")
        }
    }
}
