//
//  AirportFinderTests.swift
//  AirportFinderTests
//
//  Created by Amin on 1/16/1401 AP.
//

import XCTest
@testable import AirportFinder

class AirportFinderTests: XCTestCase {
    
    var testCase :AirportFinderViewModel!

    override func setUpWithError() throws {
        testCase = AirportFinderViewModel(networkManger: AmadeusNetworkManager())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetListOfAirportsWithLatAndLong() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
