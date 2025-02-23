//
//  NetworkError.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// 네트워킹에서 발생할 수 있는 에러를 정의합니다.
public enum NetworkError: Error {
    
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
