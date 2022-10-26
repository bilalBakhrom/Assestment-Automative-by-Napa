import XCTest
@testable import TelegramNetwork

final class WTimeServiceTests: XCTestCase {
    func testSuccessfullyFetchingTimeZone() throws {
        let session = URLSession(mockResponder: WTime.MockDataURLResponder.self)
        let sut = WTimeService(session: session)
        let timeExp = expectation(description: "Fetch world time")
        
        sut.fetchCurrentTime { result in
            if case let .success(time) = result {
                XCTAssertEqual(time.timezone, "America/Chicago")
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
