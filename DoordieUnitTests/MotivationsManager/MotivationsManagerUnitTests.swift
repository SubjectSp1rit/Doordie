//
//  MotivationsManagerTests.swift
//  DoordieUnitTests
//
//  Created by Arseniy on 08.04.2025.
//

import XCTest
@testable import Doordie

protocol MotivationsProviding {
    func motivationalPhrase(for percentage: Int) -> String
}

extension MotivationsManager: MotivationsProviding { }

protocol MotivationsProvidingTestable {
    var provider: MotivationsProviding! { get set }
}

extension MotivationsProvidingTestable where Self: XCTestCase {
    func verifyPhrase(for percentage: Int, expected: String, file: StaticString = #file, line: UInt = #line) {
        // Act
        let result = provider.motivationalPhrase(for: percentage)
        
        // Assert
        XCTAssertEqual(result, expected, "Для \(percentage)% ожидается: \"\(expected)\", получено: \"\(result)\"", file: file, line: line)
    }
    
    func testBeginNow() {
        verifyPhrase(for: 10, expected: "Begin Now!")
    }
    
    func testKeepGoing() {
        verifyPhrase(for: 25, expected: "Keep Going!")
    }
    
    func testHalfwayThere() {
        verifyPhrase(for: 50, expected: "Halfway There!")
    }
    
    func testDailyGoalsAlmostDone() {
        verifyPhrase(for: 70, expected: "Your daily goals almost done!")
    }
    
    func testNearlyThere() {
        verifyPhrase(for: 85, expected: "Nearly There!")
    }
    
    func testWellDone() {
        verifyPhrase(for: 100, expected: "Well Done!")
    }
    
    func testInvalidNegative() {
        verifyPhrase(for: -5, expected: "Invalid Percentage")
    }
    
    func testInvalidOver100() {
        verifyPhrase(for: 110, expected: "Invalid Percentage")
    }
}

final class MotivationsManagerUnitTests: XCTestCase, MotivationsProvidingTestable {
    // MARK: - Properties
    
    // DIP
    var provider: MotivationsProviding!
    
    // MARK: - Lifeycle
    override func setUp() {
        super.setUp()
        // DI
        provider = MotivationsManager.shared
    }
    
    override func tearDown() {
        provider = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    func testMotivationalPhrase_BeginNow() {
        testBeginNow()
    }
    
    func testMotivationalPhrase_KeepGoing() {
        testKeepGoing()
    }
    
    func testMotivationalPhrase_HalfwayThere() {
        testHalfwayThere()
    }
    
    func testMotivationalPhrase_DailyGoalsAlmostDone() {
        testDailyGoalsAlmostDone()
    }
    
    func testMotivationalPhrase_NearlyThere() {
        testNearlyThere()
    }
    
    func testMotivationalPhrase_WellDone() {
        testWellDone()
    }
    
    func testMotivationalPhrase_InvalidNegative() {
        testInvalidNegative()
    }
    
    func testMotivationalPhrase_InvalidOver100() {
        testInvalidOver100()
    }
}
