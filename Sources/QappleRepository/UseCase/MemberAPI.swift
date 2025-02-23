//
//  MemberAPI.swift
//  QappleRepository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

/// 멤버 API
public enum MemberAPI: Sendable {
    
    /// 테스트용 로컬 로그인 API 입니다.
    public static func localSignIn(
        testId: String,
        deviceToken: String,
        server: Server
    ) async throws -> LocalSignIn {
        let url = try QappleAPI.Member.localSignIn(
            testId: testId,
            deviceToken: deviceToken
        ).url(from: server)
        
        return try await NetworkService.signIn(
            url: url
        )
    }
    
    /// 로그인 API 입니다.
    public static func signIn(
        code: String,
        deviceToken: String,
        server: Server
    ) async throws -> SignIn {
        let url = try QappleAPI.Member.signIn(
            code: code,
            deviceToken: deviceToken
        ).url(from: server)
        
        return try await NetworkService.signIn(
            url: url
        )
    }
    
    /// 회원가입 API 입니다.
    public static func signUp(
        signUpToken: String,
        email: String,
        nickname: String,
        deviceToken: String,
        server: Server
    ) async throws -> SignUp {
        let url = try QappleAPI.Member.signUp.url(from: server)
        let request = SignUpRequest(
            signUpToken: signUpToken,
            email: email,
            nickname: nickname,
            deviceToken: deviceToken
        )
        return try await NetworkService.post(
            url: url,
            body: request
        )
    }
    
    /// 회원가입 인증메일 발송 API 입니다.
    public static func sendCertificationEmail(
        signUpToken: String,
        email: String,
        server: Server
    ) async throws -> Bool {
        let url = try QappleAPI.Member.certification(
            signUpToken: signUpToken,
            email: email
        ).url(from: server)
        
        return try await NetworkService.signIn(
            url: url
        )
    }
    
    /// 회원가입 인증코드 인증 API 입니다.
    public static func checkAuthCode(
        signUpToken: String,
        email: String,
        certCode: String,
        server: Server
    ) async throws -> Bool {
        let url = try QappleAPI.Member.certificationCodeCheck(
            signUpToken: signUpToken,
            email: email,
            certCode: certCode
        ).url(from: server)
        
        return try await NetworkService.signIn(
            url: url
        )
    }
    
    /// 닉네임 중복 API 입니다.
    public static func checkNicknameDuplicate(
        nickname: String,
        server: Server,
        accessToken: String
    ) async throws -> Bool {
        let url = try QappleAPI.Member.nicknameCheck(
            nickname: nickname
        ).url(from: server)
        
        return try await NetworkService.get(
            url: url,
            accessToken: accessToken
        )
    }
    
    /// 닉네임 조회 API 입니다.
    public static func fetchProfile(
        server: Server,
        accessToken: String
    ) async throws -> Profile {
        let url = try QappleAPI.Member.profile.url(from: server)
        
        return try await NetworkService.get(
            url: url,
            accessToken: accessToken
        )
    }
    
    /// 닉네임 수정 API 입니다.
    public static func updateProfile(
        nickname: String,
        profileImage: String?,
        server: Server,
        accessToken: String
    ) async throws -> UpdateProfile {
        let url = try QappleAPI.Member.updateProfile.url(from: server)
        let request = UpdateProfileRequest(
            nickname: nickname,
            profileImage: profileImage
        )
        
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    /// 회원탈퇴 API 입니다.
    public static func resign(
        server: Server,
        accessToken: String
    ) async throws -> Resign {
        let url = try QappleAPI.Member.resign.url(from: server)
        
        return try await NetworkService.get(
            url: url,
            accessToken: accessToken
        )
    }
}
