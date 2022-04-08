//
//  AmadeusNetworkTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/17/1401 AP.
//

import XCTest
@testable import AirportFinder

class AmadeusNetworkTests: XCTestCase {
    var testCase:AmadeusNetworkManagerProtocol!
    override func setUpWithError() throws {
        testCase = AmadeusNetworkMock()
    }

    override func tearDownWithError() throws {
        
    }

    func testGetAirportsForLatAndLongAndRadius_IsNotNil() throws {
        let expect = expectation(description: "listOfAirports")
        testCase.getListOfAirportsFor(lat: 51.57285, long: -0.44161, radius: 1000, pageLimit: 20, pageOffset: 0, sort: .relevance,token: "28hajskhf32hhkjbw" ){ airports in
            expect.fulfill()
            XCTAssertEqual(airports?.meta.count, 32)
            XCTAssertEqual(airports?.data.first?.name, "HEATHROW")
        }
        wait(for: [expect], timeout: 2)
    }

}
