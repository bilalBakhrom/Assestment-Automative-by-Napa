import XCTest
@testable import TelegramNetwork

final class WTimeServiceTests: XCTestCase {
    func testSuccessfullyFetchingTimeZone() throws {
        let session = URLSession(mockResponder: WTime.MockDataURLResponder.self)
        let sut = WTimeService(session: session)
        let timeExp = expectation(description: "Time is fetched")
        
        sut.fetchCurrentTime { result in
            XCTAssertNoThrow {
                let time = try result.get()
                XCTAssertEqual("America/Chicago", time.timezone)
                timeExp.fulfill()
            }
        }
        
        wait(for: [timeExp], timeout: 3.0)
    }
    
    func testFailingWhenEncounterError() throws {
        let session = URLSession(mockResponder: MockErrorURLResponder.self)
        let sut = WTimeService(session: session)
        let timeExp = expectation(description: "Bad id")
        
        sut.fetchCurrentTime { result in
            if case .failure = result {
                timeExp.fulfill()
            }
        }
        
        wait(for: [timeExp], timeout: 3.0)
    }
}
