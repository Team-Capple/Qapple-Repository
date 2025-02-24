//
//  BaseURL.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// API 호출을 위한 기본 URL 생성 관리
enum BaseURL {
    
    class PackageClass {}
    
    private static let scheme: String = "http"
    
    static func serverKey(_ server: Server) -> String {
        switch server {
        case .production: "PRODUCTION_URL"
        case .test: "TEST_URL"
        }
    }
    
    /// 기본 URL을 받아옵니다.
    static func fetch(from server: Server) throws -> String {
        if Bundle.main == Bundle(for: PackageClass.self) {
            guard let host = Bundle.main.infoDictionary?[serverKey(server)] as? String else {
                throw APIError.invalidSecretKey("HOST_URL_\(server.rawValue.uppercased())")
            }
            guard let port = Bundle.main.infoDictionary?["PORT_NUM"] as? String else {
                throw APIError.invalidSecretKey("PORT_NUM")
            }
            return "\(scheme)://\(host):\(port)"
        } else {
            guard let host = ProcessInfo.processInfo.environment[serverKey(server)] else {
                throw APIError.invalidSecretKey("HOST_URL_\(server.rawValue.uppercased())")
            }
            guard let port = ProcessInfo.processInfo.environment["PORT_NUM"] else {
                throw APIError.invalidSecretKey("PORT_NUM")
            }
            return "\(scheme)://\(host):\(port)"
        }
    }
}
