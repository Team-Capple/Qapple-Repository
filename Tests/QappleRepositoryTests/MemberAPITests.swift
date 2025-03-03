//
//  MemberAPITests.swift
//  QappleRepository
//
//  Created by 김민준 on 2/9/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct MemberAPITests {
    
    @Test
    func localSignIn() async throws {
        let response = try await MemberAPI.localSignIn(
            testId: "TEST_ID_\(Date.now.description)",
            deviceToken: "TEST_DEVICE_TOKEN",
            server: .test
        )
        dump(response)
    }
    
    @Test
    func localSignUp() async throws {
        let refreshToken = try await MemberAPI.localSignIn(
            testId: "TEST_ID_\(Date.now.description)",
            deviceToken: "TEST_DEVICE_TOKEN",
            server: .test
        ).refreshToken
        let response = try await MemberAPI.signUp(
            signUpToken: refreshToken,
            email: "email",
            nickname: "nickname",
            deviceToken: "deviceToken",
            server: .test
        )
        dump(response)
    }
    
    @Test("회원가입 인증메일 발송 테스트")
    func sendCertificationEmail() async throws {
        let refreshToken = try await MemberAPI.localSignIn(
            testId: "TEST_ID_\(Date.now.description)",
            deviceToken: "TEST_DEVICE_TOKEN",
            server: .test
        ).refreshToken
        let response = try await MemberAPI.sendCertificationEmail(
            signUpToken: refreshToken,
            email: "test@pos.idserve.net",
            server: .test
        )
        dump(response)
    }
    
    @Test("회원가입 인증코드 확인 테스트")
    func checkAuthCode() async throws {
        let now = Date.now
        let testEmail = "test\(now.timeIntervalSince1970)date25@pos.idserve.net"
        
        let accessToken = try await TestHelper.accessToken()
        let _ = try await MemberAPI.roleChange(
            role: .admin,
            server: .test,
            accessToken: accessToken
        )
        let _ = try await MemberAPI.emailWhitelist(
            email: testEmail,
            durationMinutes: 10,
            server: .test,
            accessToken: accessToken
        )
        let localSignUp = try await MemberAPI.localSignIn(
            testId: "TEST_ID_\(now.description)",
            deviceToken: "TEST_DEVICE_TOKEN_\(now.description)",
            server: .test
        )
        let _ = try await MemberAPI.sendCertificationEmail(
            signUpToken: localSignUp.refreshToken,
            email: testEmail,
            server: .test
        )
        guard let certCode = ProcessInfo.processInfo.environment["CERT_CODE"] else {
            throw RepositoryError.invalidSecretKey("CERT_CODE")
        }
        let response = try await MemberAPI.checkAuthCode(
            signUpToken: localSignUp.refreshToken,
            email: testEmail,
            certCode: certCode,
            server: .test
        )
        dump(response)
    }
    
    @Test("닉네임 중복 확인 테스트")
    func checkNicknameDuplicate() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await MemberAPI.checkNicknameDuplicate(
            nickname: "TestUser",
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("프로필 조회 테스트")
    func fetchProfile() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await MemberAPI.fetchProfile(
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("프로필 수정 테스트")
    func updateProfile() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await MemberAPI.updateProfile(
            nickname: "User\(Int.random(in: 1...100))",
            profileImage: nil,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("회원탈퇴 테스트")
    func resign() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await MemberAPI.resign(
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
}
