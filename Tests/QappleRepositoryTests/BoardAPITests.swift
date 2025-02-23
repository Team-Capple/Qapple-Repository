//
//  BoardAPITests.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct BoardAPITests {
    
    @Test("게시글 리스트 조회 테스트")
    func fetchList() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardAPI.fetchList(
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 생성 테스트")
    func create() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardAPI.create(
            content: "테스트 게시글",
            boardType: .freeBoard,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 단건 조회 테스트")
    func fetchSingle() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardAPI.fetchSingle(
            boardId: 1,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 삭제 테스트")
    func delete() async throws {
        let accessToken = try await TestHelper.accessToken()
        let create = try await BoardAPI.create(
            content: "테스트 게시글",
            boardType: .freeBoard,
            server: .test,
            accessToken: accessToken
        )
        let delete = try await BoardAPI.fetchSingle(
            boardId: create.boardId,
            server: .test,
            accessToken: accessToken
        )
        dump(delete)
    }
    
    @Test("게시글 좋아요 및 취소 테스트")
    func like() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardAPI.like(
            boardId: 1,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
    
    @Test("게시글 검색 테스트")
    func search() async throws {
        let accessToken = try await TestHelper.accessToken()
        let response = try await BoardAPI.search(
            keyword: "ㅇ",
            threshold: nil,
            pageSize: 30,
            server: .test,
            accessToken: accessToken
        )
        dump(response)
    }
}
