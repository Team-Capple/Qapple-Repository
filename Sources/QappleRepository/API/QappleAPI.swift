//
//  QappleAPI.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Foundation

enum QappleAPI {
    
    struct BaseResponse<ResultType: Decodable>: Decodable {
        let timeStamp: String
        let code: String
        let message: String
        let result: ResultType
    }
    
    // MARK: - Answer
    
    enum Answer: RawRepresentable, API {
        static let basePath = "answers"
        
        /// 작성한 답변 조회
        case listOfMine(threshold: Int?, pageSize: Int32 = 25)
        
        /// 답변 삭제
        case delete(answerId: Int64)
        
        /// 질문에 대한 답변 조회
        case listOfQuestion(questionId: Int64, threshold: String?, pageSize: Int32 = 25)
        
        /// 답변 생성
        case create(questionId: Int64)
        
        var rawValue: RawValue {
            switch self {
            case let .listOfMine(threshold, pageSize):
                appending(urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
                
            case let .delete(answerId):
                appending(baseString: "\(answerId)")
                
            case let .listOfQuestion(questionId, threshold, pageSize):
                appending(baseString: "question/\(questionId)", urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
                
            case let .create(questionId):
                appending(baseString: "question/\(questionId)")
            }
        }
    }
    
    // MARK: - Member
    
    enum Member: RawRepresentable, API {
        static let basePath = "members"
        
        /// 회원가입 인증메일 발송
        case certification(signUpToken: String, email: String)
        
        /// 회원가입 인증코드 인증
        case certificationCodeCheck(signUpToken: String, email: String, certCode: String)
        
        /// 이메일 중복 체크
        case check(email: String)
        
        /// 테스트용 로컬 로그인
        case localSignIn(testId: String, deviceToken: String)
        
        /// 마이페이지 프로필 조회
        case profile
        
        /// 마이페이지 프로필 수정
        case updateProfile
        
        /// 닉네임 중복 체크
        case nicknameCheck(nickname: String)
        
        /// 회원탈퇴
        case resign
        
        /// 로그인
        case signIn(code: String, deviceToken: String)
        
        /// 회원가입
        case signUp
        
        /// 사용자 자격 변경
        case roleChange(role: String)
        
        var rawValue: RawValue {
            switch self {
            case let .certification(signUpToken, email):
                appending(baseString: "email/certification", urlQueryItems: [
                    .init(key: "signUpToken", value: signUpToken),
                    .init(key: "email", value: email),
                ])
                
            case let .certificationCodeCheck(signUpToken, email, certCode):
                appending(baseString: "email/certification/check", urlQueryItems: [
                    .init(key: "signUpToken", value: signUpToken),
                    .init(key: "email", value: email),
                    .init(key: "certCode", value: certCode),
                ])
                
            case let .check(email):
                appending(baseString: "email/check", urlQueryItems: [
                    .init(key: "email", value: email)
                ])
                
            case let .localSignIn(testId, deviceToken):
                appending(baseString: "local-sign-in", urlQueryItems: [
                    .init(key: "testId", value: testId),
                    .init(key: "deviceToken", value: deviceToken)
                ])
                
            case .profile:
                appending(baseString: "mypage")
                
            case .updateProfile:
                appending(baseString: "mypage")
                
            case let .nicknameCheck(nickname):
                appending(baseString: "nickname/check", urlQueryItems: [
                    .init(key: "nickname", value: nickname),
                ])
                
            case .resign:
                appending(baseString: "resign")
                
            case let .signIn(code, deviceToken):
                appending(baseString: "sign-in", urlQueryItems: [
                    .init(key: "code", value: code),
                    .init(key: "deviceToken", value: deviceToken),
                ])
                
            case .signUp:
                appending(baseString: "sign-up")
                
            case let .roleChange(role):
                appending(baseString: "role/change", urlQueryItems: [
                    .init(key: "role", value: role)
                ])
            }
        }
    }
    
    // MARK: - Board
    
    enum Board: RawRepresentable, API {
        static let basePath = "boards"
        
        /// 게시글 조회
        case list(threshold: Int?, pageSize: Int32 = 25)
      
        /// 게시글 생성
        case create
        
        /// 게시글 단건 조회
        case single(boardId: Int64)
        
        /// 게시글 삭제
        case delete(boardId: Int64)
        
        /// 게시글 좋아요 및 취소
        case like(boardId: Int64)
        
        /// 게시글 검색
        case search(keyword: String?, threshold: Int?, pageSize: Int32 = 25)
        
        var rawValue: RawValue {
            switch self {
            case let .list(threshold, pageSize):
                appending(urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
                
            case .create:
                appending()
                
            case let .single(boardId):
                appending(baseString: "\(boardId)")
                
            case let .delete(boardId):
                appending(baseString: "\(boardId)")
                
            case let .like(boardId):
                appending(baseString: "\(boardId)/heart")
                
            case let .search(keyword, threshold, pageSize):
                appending(baseString: "search", urlQueryItems: [
                    .init(key: "keyword", value: keyword),
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
            }
        }
    }
    
    // MARK: - Question
    
    enum Question: RawRepresentable, API {
        static let basePath = "questions"
        
        /// 메인 질문 조회
        case listOfMain
      
        /// 모든 질문 조회
        case list(threshold: String?, pageSize: Int32 = 25)
        
        var rawValue: RawValue {
            switch self {
            case .listOfMain:
                appending(baseString: "main")
                
            case let .list(threshold, pageSize):
                appending(urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
            }
        }
    }
    
    // MARK: - Admin Question
    
    enum AdminQuestion: RawRepresentable, API {
        static let basePath = "admin/questions"
        
        case createQuestion
        case deleteQuestion(questionId: Int64)
        case uploadCSV
        
        var rawValue: RawValue {
            switch self {
            case .createQuestion:
                appending()
            case .deleteQuestion(let questionId):
                appending(baseString: "\(questionId)")
            case .uploadCSV:
                appending(baseString: "upload/csv")
            }
        }
    }
    
    // MARK: - BoardComment
    
    enum BoardComment: RawRepresentable, API {
        static let basePath = "board-comments"
        
        /// 게시글 댓글 리스트 조회
        case list(boardId: Int64, threshold: Int?, pageSize: Int32 = 25)
        
        /// 게시글 댓글 삭제
        case delete(commentId: Int64)
        
        /// 게시글 댓글 생성
        case create(boardId: Int64)
        
        /// 게시글 댓글 좋아요 및 취소
        case like(commentId: Int64)
        
        var rawValue: RawValue {
            switch self {
            case let .list(boardId, threshold, pageSize):
                appending(baseString: "\(boardId)", urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
                
            case let .delete(commentId):
                appending(baseString: "\(commentId)")
                
            case let .create(boardId):
                appending(baseString: "board/\(boardId)")
                
            case let .like(commentId):
                appending(baseString: "heart/\(commentId)")
            }
        }
    }
    
    // MARK: - Notification
    
    enum Notification: RawRepresentable, API {
        static let basePath = "notifications"
        
        /// 알림 리스트 조회
        case list(threshold: Int?, pageSize: Int32 = 25)
        
        var rawValue: RawValue {
            switch self {
            case let .list(threshold, pageSize):
                appending(urlQueryItems: [
                    .init(key: "threshold", value: threshold),
                    .init(key: "pageSize", value: pageSize),
                ])
                
            }
        }
    }
    
    // MARK: - Reports
    
    enum Reports: RawRepresentable, API {
        static let basePath = "reports"
        
        /// 게시글 신고
        case board
        
        /// 게시글 댓글 신고
        case boardComment
        
        /// 답변 신고
        case answer
        
        var rawValue: RawValue {
            switch self {
            case .board:
                appending(baseString: "board")
                
            case .boardComment:
                appending(baseString: "board-comment")
                
            case .answer:
                appending()
            }
        }
    }
    
    // MARK: - Token
    
    enum Token: RawRepresentable, API {
        static let basePath = "token"
        
        case refresh
        
        var rawValue: RawValue {
            switch self {
            case .refresh:
                appending(baseString: "refresh")
            }
        }
    }
}
