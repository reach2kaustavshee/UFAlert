//
//  UFAlertTest.swift
//  UFAlertTests
//
//  Created by Kaustav Shee on 23/11/19.
//  Copyright © 2019 Kaustav Shee. All rights reserved.
//

import XCTest
@testable import UFAlert

class UFAlertTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDisplayShortAlert() {
        UFAlert.displayAlert(withMessage: "Hello Message", Header: "Hello Title")
        XCTAssert(true)
    }
    func testDisplayLongAlert() {
        let okClouser = ActionHandler(
            "OK",
            {
                debugPrint("OK Pressed")
        },
            .default
        )
        UFAlert.displayAlert(fromViewController: nil, withMessage: "Test Message", Header: "Test Title", .alert, handlers: [okClouser], {
            debugPrint("Alert Presented")
        }) {
            debugPrint("Alert Dismissed")
        }
        XCTAssert(true)
    }

    func testPerformanceShortExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            UFAlert.displayAlert(withMessage: "Hello Message", Header: "Hello Title")
        }
    }
    func testPerformanceLongExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let okClouser = ActionHandler(
                "OK",
                {
                    debugPrint("OK Pressed")
            },
                .default
            )
            UFAlert.displayAlert(fromViewController: nil, withMessage: "Test Message", Header: "Test Title", .alert, handlers: [okClouser], {
                debugPrint("Alert Presented")
            }) {
                debugPrint("Alert Dismissed")
            }
        }
    }

}
