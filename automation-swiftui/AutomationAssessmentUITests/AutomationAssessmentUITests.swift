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
                .tagNavigationTap(topic: "Technology")
                .verifyTechnologyContentNavigation()
                .waitForPage()
        }
        
        func testScenarioFive() throws {
            let pageModel = TestingPageModel(app: app)
            pageModel.verifyTopicSelection(topic: "TV Guide")
                .tagNavigationTap(topic: "TV Guide")
                .verifyAlertDialog(tapOption: "No")
                .waitForPage()
        }
        
        func testScenarioSix() throws {
            let pageModel = TestingPageModel(app: app)
            pageModel.verifyTopicSelection(topic: "TV Guide")
                .tagNavigationTap(topic: "TV Guide")
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
