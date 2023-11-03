//
//  ExtensionsTests.swift
//  ImageAppTests
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import XCTest
@testable import ImageApp

final class ExtensionsTests: XCTestCase {
 
    func testGetAccountFromStringUrl() throws {
        let urlString = "https://imageapp.com/?state=APPLICATION_STATE#access_token=39a7cd2b2db7b953e392d8a4ab47dd3c1e81d718&expires_in=315360000&token_type=bearer&refresh_token=57fbb54998c1c901d631bcf342d340893097eff1&account_username=radostTest&account_id=175735105"
        
        let account = urlString.getAccount()
        
        let access_token = "39a7cd2b2db7b953e392d8a4ab47dd3c1e81d718"
        let expires_in = "315360000"
        let refresh_token = "57fbb54998c1c901d631bcf342d340893097eff1"
        let account_username = "radostTest"
        let account_id = "175735105"
                
        XCTAssertEqual(account?.access_token, access_token)
        XCTAssertEqual(account?.expires_in, expires_in)
        XCTAssertEqual(account?.refresh_token, refresh_token)
        XCTAssertEqual(account?.userName, account_username)
        XCTAssertEqual(account?.account_id, account_id)
    }
    
    
}
