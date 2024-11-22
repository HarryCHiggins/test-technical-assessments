//
//  AutomationAssessmentUITests.swift
//  AutomationAssessmentUITests
//
//  Created by Nicholas Jones - Mobile iPlayer - Erbium on 29/10/2024.
//

import XCTest

final class AutomationAssessmentUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app.terminate()
        app = nil
        try super.tearDownWithError()
    }

    func testScenarioOne() throws {
        let homePage = TestingPageModel(app: app)
        homePage.waitForPage()
    }
    
    func testScenarioTwo() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.verifyRefreshButtonUpdatesLastUpdated()
    }
    
    func testScenarioThree() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.verifyTopicSelection(topic: "Technology")
    }
    
    func testScenarioFour() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.verifyTopicSelection(topic: "Technology")
            .verifyTechnologyContentNavigation()
    }
    
    func testScenarioFive() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.verifyTopicSelection(topic: "TV Guide")
            .verifyAlertDialog(tapOption: "No")
            .waitForPage()
    }
    
    func testScenarioSix() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.verifyTopicSelection(topic: "TV Guide")
            .verifyAlertDialog(tapOption: "Yes")
            .verifyContentPageNavigation()
            .waitForPage()
    }
    
    func testScenarioSeven() throws {
        let pageModel = TestingPageModel(app: app)
        pageModel.tapBreakingNewsAndVerifyError()
            .verifyStableAppState()
    }
}
