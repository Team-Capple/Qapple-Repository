//
//  NetworkService.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// 네트워킹을 수행할 클라이언트 객체
enum NetworkService {
    
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    
    /// 로그인을 요청합니다.
    ///
    /// - AccessToken 없이 API를 호출합니다.
    static func signIn<T: Decodable>(url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        try checkStatusCode(response: response, data: data)
        return try decoding(data: data, response: response)
    }
    
    /// GET 요청을 수행합니다.
    static func get<T: Decodable>(url: URL, accessToken: String) async throws -> T {
        let (data, response) = try await request(url: url, method: .GET, accessToken: accessToken)
        try checkStatusCode(response: response, data: data)
        return try decoding(data: data, response: response)
    }
    
    /// POST 요청을 수행합니다.
    static func post<T: Decodable, U: Encodable>(url: URL, body: U, accessToken: String = "") async throws -> T {
        let (data, response) = try await request(url: url, body: body, method: .POST, accessToken: accessToken)
        try checkStatusCode(response: response, data: data)
        return try decoding(data: data, response: response)
    }
    
    /// PATCH 요청을 수행합니다.
    static func patch<T: Decodable, U: Encodable>(url: URL, body: U, accessToken: String) async throws -> T {
        let (data, response) = try await request(url: url, body: body, method: .PATCH, accessToken: accessToken)
        try checkStatusCode(response: response, data: data)
        return try decoding(data: data, response: response)
    }
    
    /// DELETE 요청을 수행합니다.
    static func delete<T: Decodable>(url: URL, accessToken: String) async throws -> T {
        // 네트워킹 수행
        let (data, response) = try await request(url: url, method: .DELETE, accessToken: accessToken)
        try checkStatusCode(response: response, data: data)
        return try decoding(data: data, response: response)
    }
    
    //    static func postCSV(url: URL, csvData: Data, accessToken: String = "") async throws -> Int {
    //        let (data, response) = try await requestFormData(url: url, data: csvData, method: .POST, accessToken: accessToken)
    //        return try decodeResponse(data: data, response: response)
    //    }
}

// MARK: - URLSession

extension NetworkService {
    
    /// URLSession을 통한 네트워킹을 수행합니다.
    ///
    /// - 커스텀 에러(NetworkError)를 반환하기 위해, 재사용을 염두에 두고 함수로 감싸주었습니다.
    private static func request(url: URL, body: Encodable? = nil, method: HTTPMethod, accessToken: String) async throws -> (Data, URLResponse) {
        do {
            let accessToken = "Bearer \(accessToken)"
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
            
            if let body = body {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try encoder.encode(body)
            }
            
            return try await URLSession.shared.data(for: request)
        } catch {
            throw RepositoryError.urlRequestFailure(urlString: url.absoluteString)
        }
    }
    
    //    static func requestFormData(url: URL, data: Data, method: HTTPMethod, accessToken: String) async throws -> (Data, URLResponse) {
    //        do {
    //            let accessToken = "Bearer \(accessToken)"
    //            let boundary = "Boundary-\(UUID().uuidString)"
    //
    //            var request = URLRequest(url: url)
    //            request.httpMethod = method.rawValue
    //            request.setValue(accessToken, forHTTPHeaderField: "Authorization")
    //            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    //
    //            var body = Data()
    //            body.append("--\(boundary)\r\n".data(using: .utf8)!)
    //            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\("file.csv")\"\r\n".data(using: .utf8)!)
    //            body.append("Content-Type: text/csv\r\n\r\n".data(using: .utf8)!)
    //            body.append(data)
    //            body.append("\r\n".data(using: .utf8)!)
    //            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    //
    //            return try await URLSession.shared.upload(for: request, from: body)
    //        } catch {
    //            throw NetworkError.urlRequestFailure(urlString: url.absoluteString)
    //        }
    //    }
}

// MARK: - Status Code

extension NetworkService {
    
    /// URLResponse의 StatusCode를 반환합니다.
    private static func statusCode(_ response: URLResponse) -> Int {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            return 400
        }
        return statusCode
    }
    
    /// StatusCode의 상태값이 성공인지 확인합니다.
    private static func checkStatusCode(response: URLResponse, data: Data) throws {
        let statusCode = statusCode(response)
        let successStatusCodeRange = 200...299
        guard successStatusCodeRange.contains(statusCode) else {
            if statusCode == 403 {
                throw RepositoryError.authenticationFailed
            } else {
                let failedResponse = try? decoder.decode(
                    RepositoryError.FailedResponse.self,
                    from: data
                )
                throw RepositoryError.invalidResponse(
                    urlString: response.url?.absoluteString ?? "",
                    statusCode: statusCode,
                    message: failedResponse?.message ?? "에러 메시지 없음"
                )
            }
        }
    }
}

// MARK: - Decoding

extension NetworkService {
    
    /// 응답을 검증하고 데이터를 디코딩한 결과를 반환합니다.
    private static func decoding<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        do {
            let decodedData = try decoder.decode(
                QappleAPI.BaseResponse<T>.self,
                from: data
            )
            return decodedData.result
        } catch {
            throw RepositoryError.decodingFailure(type: T.self)
        }
    }
}
