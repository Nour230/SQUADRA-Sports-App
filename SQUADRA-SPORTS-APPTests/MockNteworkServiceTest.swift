//
//  MockNteworkServiceTest.swift
//  SQUADRA-SPORTS-APPTests
//
//  Created by nourhan essam on 04/06/2025.
//

import XCTest

final class MockNteworkServiceTest: XCTestCase {

    var fakeNetwork :FakeNetwork!
    override func setUpWithError() throws {
         fakeNetwork  = FakeNetwork(shouldReturnError: false)
    }

    override func tearDownWithError() throws {
        fakeNetwork = nil
    }

    func testNetworkService(){
            fakeNetwork.getLeagues(sport: "football") { res in
                if res.isEmpty{
                    XCTAssertNil(res)
                }else{
                    XCTAssertNotNil(res)
                }
            }
        }

}
