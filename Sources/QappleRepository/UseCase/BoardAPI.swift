//
//  BoardAPI.swift
//  QappleRepository
//
//  Created by 김민준 on 2/12/25.
//

import Foundation

/// 게시판 API
public enum BoardAPI {
    
    /// 게시글을 조회 API입니다.
    public static func fetchList(
        threshold: Int?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> BoardList {
        let url = try QappleAPI.Board.list(
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 게시글 생성 API입니다.
    public static func create(
        content: String,
        boardType: CreateBoardRequest.BoardType,
        server: Server,
        accessToken: String
    ) async throws -> CreateBoard {
        let url = try QappleAPI.Board.create.url(from: server)
        let request = CreateBoardRequest(content: content, boardType: boardType.rawValue)
        return try await NetworkService.post(
            url: url,
            body: request,
            accessToken: accessToken
        )
    }
    
    /// 단일 게시글을 조회하는 API입니다.
    public static func fetchSingle(
        boardId: Int,
        server: Server,
        accessToken: String
    ) async throws -> SingleBoard {
        let url = try QappleAPI.Board.single(boardId: Int64(boardId)).url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
    
    /// 게시글 삭제 API입니다.
    public static func delete(
        boardId: Int,
        server: Server,
        accessToken: String
    ) async throws -> DeleteBoard {
        let url = try QappleAPI.Board.delete(boardId: Int64(boardId)).url(from: server)
        return try await NetworkService.delete(url: url, accessToken: accessToken)
    }
    
    /// 게시글 좋아요 및 취소 API입니다.
    public static func like(
        boardId: Int,
        server: Server,
        accessToken: String
    ) async throws -> LikeBoard {
        let url = try QappleAPI.Board.like(boardId: Int64(boardId)).url(from: server)
        let request = LikeBoardRequest(boardId: boardId)
        return try await NetworkService.post(url: url, body: request, accessToken: accessToken)
    }
    
    /// 게시글 검색 API입니다.
    public static func search(
        keyword: String,
        threshold: Int?,
        pageSize: Int,
        server: Server,
        accessToken: String
    ) async throws -> SearchBoard {
        let url = try QappleAPI.Board.search(
            keyword: keyword,
            threshold: threshold,
            pageSize: Int32(pageSize)
        ).url(from: server)
        return try await NetworkService.get(url: url, accessToken: accessToken)
    }
}
