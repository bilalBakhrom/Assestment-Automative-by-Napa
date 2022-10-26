//
//  CallServiceTests.swift
//  
//
//  Created by Bilal Bakhrom on 26/10/2022.
//

import XCTest
@testable import TelegramNetwork

final class CallServiceTests: XCTestCase {
    func testSuccessfullyFetchingCalls() throws {
        let session = URLSession(mockResponder: Call.MockDataURLResponder.self)
        let sut = CallService(session: session)
        let timeExp = expectation(description: "Fetch calls")
        
        sut.fetchCallList { result in
            if case let .success(calls) = result {
                XCTAssertEqual(calls.count, 4)
                timeExp.fulfill()
            }
        }
        
        wait(for: [timeExp], timeout: 3.0)
    }
    
    func testFailingWhenEncounterError() throws {
        let session = URLSession(mockResponder: MockErrorURLResponder.self)
        let sut = CallService(session: session)
        let timeExp = expectation(description: "Bad id")
        
        sut.fetchCallList { result in
            if case .failure = result {
                timeExp.fulfill()
            }
        }
        
        wait(for: [timeExp], timeout: 3.0)
    }
}
