//
//  DoordieUITests.swift
//  DoordieUITests
//
//  Created by Arseniy on 07.04.2025.
//

import XCTest

final class DoordieUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    @MainActor
    func testLoginFromWelcomeScreen() throws {
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Log in"].tap()
        app.textFields["example@doordie.app"].tap()
        app.textFields["example@doordie.app"].typeText("qwe@qwe.qwe")
        app.secureTextFields["••••••••"].tap()
        app.secureTextFields["••••••••"].typeText("qweqweqwe")
        app.buttons["Log in"].tap()
        
        Thread.sleep(forTimeInterval: 2)
        
        XCTAssert(app.tabBars["Tab Bar"].exists)
    }

    @MainActor
    func testFromHomeScreenToWelcomeScreenThroughLogoutInSettingsScreen() throws {
        let app = XCUIApplication()
        app.launch()

        app.tabBars.buttons["Settings"].tap()
        app.tables.cells.staticTexts["Logout"].tap()
        app.alerts["Are you sure you want to log out?"].buttons["Logout"].tap()
        
        XCTAssert(app.navigationBars["Doordie.WelcomeView"].exists)
    }

    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
