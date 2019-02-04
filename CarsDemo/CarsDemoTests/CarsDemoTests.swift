//
//  CarsDemoTests.swift
//  CarsDemoTests
//
//  Created by Abhishek Chaudhari on 09/08/18.
//  Copyright © 2018 Abhishek Chaudhari. All rights reserved.
//

import XCTest
@testable import CarsDemo

class CarsDemoTests: XCTestCase {
    func testTimeTextCheck(){ // only for 12hr clock
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy, hh:mm a"
        
        let timestamp2017 = 1511968425
        let date2017 = Date(timeIntervalSince1970: TimeInterval(timestamp2017))
        
        XCTAssertEqual(Date.getTimeString(fromTimeStamp: Int32(timestamp2017)), dateFormatter.string(from: date2017))
        
        let timestamp2018 = 1533798507
        dateFormatter.dateFormat = "dd MMMM, hh:mm a"
        let date2018 = Date(timeIntervalSince1970: TimeInterval(timestamp2018))
        
        XCTAssertEqual(Date.getTimeString(fromTimeStamp: Int32(timestamp2018)), dateFormatter.string(from: date2018))
    }
}
