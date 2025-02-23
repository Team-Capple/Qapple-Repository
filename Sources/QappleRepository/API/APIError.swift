//
//  APIError.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// Repository 에러 열거형
public enum APIError: Error {
    
    /// 유효하지 않은 SecretKey 에러
    case invalidSecretKey(String)
    
    /// 기본 URL 에러
    case invalidBaseUrl(String)
}
