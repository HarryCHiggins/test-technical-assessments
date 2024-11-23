//
//  TestHelper.swift
//  AutomationAssessment
//
//  Created by Harry Higgins on 22/11/2024.
//

import XCTest

extension XCUIElement{
    
    func waitForNonExistance(timeout: TimeInterval) -> Bool {
        let predicate = NSPredicate(format: "exists == FALSE")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result == .completed && !self.exists
    }
    
    func waitForElement(description: String, timeout: TimeInterval) {
            XCTAssertTrue(self.waitForExistence(timeout: timeout), "\(description) does not exist within \(timeout) seconds")
        }
}
