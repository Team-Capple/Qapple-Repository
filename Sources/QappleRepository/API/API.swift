//
//  API.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// API를 추상화하는 프로토콜
protocol API {
    
    /// 기본 Base URL
    static var basePath: String { get }
    
    /// BaseString과 URLQuery를 이어 붙여 URLString을 반환합니다.
    func appending(baseString: String?, urlQueryItems: [APIQuery]) -> String
}

// MARK: - Helper

extension API {
    
    /// BaseString과 URLQuery를 이어 붙여 URLString을 반환합니다.
    func appending(baseString: String? = nil, urlQueryItems: [APIQuery] = []) -> String {
        
        var absoluteString = ""
        if let baseString = baseString { absoluteString = "/" + baseString + "?" }
        else { absoluteString = "?" }
        
        for index in urlQueryItems.indices {
            let key = urlQueryItems[index].key
            if let value = urlQueryItems[index].value {
                absoluteString += "\(key)" + "=" + "\(value)" + "&"
            }
        }
        
        absoluteString.removeLast()
        return absoluteString
    }
}

// MARK: - RawRepresentable

extension RawRepresentable where RawValue == String, Self: API {
    
    /// 프로토콜 준수용 생성자
    init?(rawValue: String) { nil }
    
    /// 원시값을 이용해 URL 타입으로 변환 후 반환합니다.
    func url(from server: Server) throws -> URL {
        let baseURLString = try BaseURL.fetch(from: server)
        guard let baseURL = URL(string: baseURLString)?
            .appendingPathComponent(Self.basePath) else {
            throw RepositoryError.invalidBaseUrl("BaseURL Error: \(baseURLString)")
        }
        guard let url = URL(string: baseURL.absoluteString + rawValue) else {
            throw RepositoryError.invalidBaseUrl("RawValue Error: \(rawValue)")
        }
        return url
    }
}
