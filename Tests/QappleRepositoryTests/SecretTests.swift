//
//  SecretTests.swift
//  Qapple-Repository
//
//  Created by 김민준 on 2/9/25.
//

import Testing
import Foundation
@testable import QappleRepository

struct SecretTests {
    
    @Test
    func productionServerURL() throws {
        let url = try BaseURL.fetch(from: .production)
        dump(url)
        #expect(url != "HOST URL ERROR")
    }
    
    @Test
    func testServerURL() throws {
        let url = try BaseURL.fetch(from: .test)
        dump(url)
        #expect(url != "HOST URL ERROR")
    }
}
