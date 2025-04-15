//
//  NotificationAPITests.swift
//  QappleRepository
//
//  Created by 문인범 on 2/14/25.
//

import Foundation
import Testing
@testable import QappleRepository


struct NotificationAPITests {
    
    @Test("알림 리스트 조회 테스트")
    func fetchNotifications() async throws {
        let _ = try await NotificationAPI.fetchNotifications(
            threshold: nil,
            pageSize: 25,
            server: .test,
            accessToken: TestHelper.accessToken()
        )
    }
}
