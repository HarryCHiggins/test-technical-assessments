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
            let pageModel = TestingPageModel(app: app)
            pageModel.waitForPage()
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
                .tagNavigationTap()
                .verifyContentPage(topic: "Technology")
                .waitForPage()
        }
        
        func testScenarioFive() throws {
            let pageModel = TestingPageModel(app: app)
            pageModel.verifyTopicSelection(topic: "TV Guide")
                .tagNavigationTap()
                .verifyAlertDialog(alertLabel: "Do you have a TV license?", tapOption: "No")
                .waitForPage()
        }
        
        func testScenarioSix() throws {
            let pageModel = TestingPageModel(app: app)
            pageModel.verifyTopicSelection(topic: "TV Guide")
                .tagNavigationTap()
                .verifyAlertDialog(alertLabel: "Do you have a TV license?", tapOption: "Yes")
                .verifyContentPage(topic: "TV Guide")
                .waitForPage()
        }
        
        func testScenarioSeven() throws {
            let pageModel = TestingPageModel(app: app)
            pageModel.tapBreakingNewsAndVerifyError()
                .verifyStableAppState()
        }
    }
