//
//  AutomationAssessmentUITestsLaunchTests.swift
//  AutomationAssessmentUITests
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import XCTest

final class AutomationAssessmentUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
