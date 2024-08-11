import Foundation
import XCTest

import OpenapiGenerated

import OpenAPIRuntime
import OpenAPIURLSession

final class NofficeTests: XCTestCase {
    
    private var client: APIProtocol!
    
    override func setUp() {
        super.setUp()
        client = Client(
            serverURL: URL(string: "https://api.noffice.store")!,
            transport: URLSessionTransport()
        )
    }
    
    func test_twoPlusTwo_isFour() {
        XCTAssertEqual(2+2, 4)
    }
    
    func test_openapiGenerated() {
        // Create an expectation for the asynchronous operation
        let expectation = self.expectation(description: "Async operation")
        
        // Perform the asynchronous operation
        Task {
            do {
                let response = try await client.health()
                
                // Verify the response and fulfill the expectation
                XCTAssertNotNil(response, "Response should not be nil")
                print("::: \(response)")
                
                // Fulfill the expectation to indicate that the asynchronous operation is complete
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
                expectation.fulfill() // Fulfill the expectation even if there is an error to avoid hanging tests
            }
        }
        
        // Wait for the expectation to be fulfilled, with a timeout to prevent hanging tests
        waitForExpectations(timeout: 5.0) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
}
