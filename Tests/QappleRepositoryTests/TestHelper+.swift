//
//  TestHelper.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Foundation
import QappleRepository

enum TestHelper {
    
    /// 테스트 토큰을 발급합니다.
    static func accessToken() async throws -> String {
        let localSignIn = try await MemberAPI.localSignIn(
            testId: "dd",
            deviceToken: "dd",
            server: .test
        )
//        let localSignUp = try await MemberAPI.signUp(
//            signUpToken: localSignIn.refreshToken,
//            email: "email",
//            nickname: "nickname",
//            deviceToken: "dd",
//            server: .test
//        )
        return localSignIn.accessToken ?? ""
    }
}
