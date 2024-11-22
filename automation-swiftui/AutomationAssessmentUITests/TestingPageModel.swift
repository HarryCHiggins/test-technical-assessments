import XCTest
@testable import AutomationAssessment

protocol Page {
    var app: XCUIApplication { get }

    @discardableResult
    func waitForPage() -> Self
}

struct TestingPageModel: Page {
    var app: XCUIApplication
    
    // UI Elements
    var homeTitle: XCUIElement { app.staticTexts[AutomationIdentifiers.homeTitle.rawValue]}
    var homeSubtitle: XCUIElement { app.staticTexts[AutomationIdentifiers.homeSubtitle.rawValue]}
    var lastUpdated: XCUIElement { app.staticTexts[AutomationIdentifiers.lastUpdated.rawValue]}
    var tagNavigation: XCUIElement { app.buttons[AutomationIdentifiers.tagNavigation.rawValue]}
    var tagPicker: XCUIElement { app.buttons[AutomationIdentifiers.tagPicker.rawValue]}
    var homeFooterButton: XCUIElement { app.buttons[AutomationIdentifiers.homeFooterButton.rawValue]}
    var refreshButton: XCUIElement { app.buttons["arrow.clockwise.circle.fill"]}
    
    // Content Page Text
    var contentText: XCUIElement { app.staticTexts[AutomationIdentifiers.contentText.rawValue]}
    
    private var backButton: XCUIElement { app.navigationBars.buttons.element(boundBy: 0)}
    
    @discardableResult
    func waitForPage() -> Self {
        
        // Verify that no loading indicators still exist on the page
        let loadingIndicator = app.activityIndicators.firstMatch
        XCTAssertFalse(loadingIndicator.exists)
        
        // Check that all essential elements exist on the page
        XCTAssertTrue(homeTitle.exists, "HomeTitle does not exist")
        XCTAssertTrue(homeSubtitle.exists, "HomeSubtitle does not exist")
        XCTAssertTrue(lastUpdated.exists, "LastUpdated does not exist")
        XCTAssertTrue(tagNavigation.exists, "TagNavigation does not exist")
        XCTAssertTrue(tagPicker.exists, "TagPicker does not exist")
        XCTAssertTrue(homeFooterButton.exists, "HomeFooterButton does not exist")
        
        return self
    }
    
    @discardableResult
    func verifyRefreshButtonUpdatesLastUpdated() -> Self {
        // Verify initial state
        XCTAssertTrue(lastUpdated.waitForExistence(timeout: 5), "Last Updated label not found in initial state")
        let initialLastUpdated = lastUpdated.label
        XCTAssertTrue(refreshButton.waitForExistence(timeout: 5), "Refresh Button not found")
        
        // Perform refresh
        refreshButton.tap()
        
        // Verify loading state and wait for completion
        let loadingIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 5), "Loading indicator did not appear after refresh")
        let loadingDisappeared = loadingIndicator.waitForNonExistance(timeout: 10)
        XCTAssertTrue(loadingDisappeared, "Loading indicator did not disappear within 10 seconds")
        
        // Verify updated state
        XCTAssertTrue(lastUpdated.waitForExistence(timeout: 5), "Last Updated label not found after refresh")
        let newLastUpdated = lastUpdated.label
        
        XCTAssertFalse(newLastUpdated.isEmpty, "New last updated time is empty")
        XCTAssertNotEqual(newLastUpdated, initialLastUpdated, "Last updated time did not change after refresh")
        
        return self
    }
    
    @discardableResult
    func verifyTopicSelection(topic: String) -> Self {
        // Find the Tag Picker
        XCTAssertTrue(tagPicker.waitForExistence(timeout: 5), "Tag Picker not found")
        tagPicker.tap()
        
        // Select the Technology option
        let topicOption = app.buttons[topic]
        XCTAssertTrue(topicOption.waitForExistence(timeout: 5),"\(topic) option not found in picker")
        topicOption.tap()
        
        // Verify that the tagNavigation has the correct label
        XCTAssertTrue(tagNavigation.waitForExistence(timeout: 5), "Go to \(topic) link not found")
        XCTAssertEqual(tagNavigation.label, "Go to \(topic)", "Tag Navigation label has the incorrect text")
        
        return self
    }
    
    @discardableResult
    func verifyTechnologyContentNavigation() -> Self {
        // This step chains onto the step we made previously to select the Technology options so the first thing we need to do is tap
        tagNavigation.tap()
        
        // Verify content loaded
        XCTAssertTrue(contentText.waitForExistence(timeout: 5), "Content text not found")
        
        // Scroll to bottom of page and check text
        var attempts = 0
        let maxAttempts = 10
        let targetText = "This is the end of the placeholder text."
        var foundEndText = false
        
        while attempts < maxAttempts {
            if contentText.label.contains(targetText){
                foundEndText = true
                break
            }
            app.swipeUp()
            attempts += 1
        }
        
        XCTAssertTrue(foundEndText, "End text does not exist")
        
        // Navigate back
        XCTAssertTrue(backButton.waitForExistence(timeout: 5), "Back button not found")
        backButton.tap()
        
        // Verify we are back on the homepage
        XCTAssertTrue(homeTitle.waitForExistence(timeout: 5), "Did not return to homepage")
        
        return self
    }
    
    @discardableResult
    func verifyAlertDialog(tapOption: String) -> Self {
        tagNavigation.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Alert dialog did not appear")
        
        let button = alert.buttons[tapOption]
        XCTAssertTrue(button.exists, "\(tapOption) button not found in alert")
        button.tap()
        
        return self
        
    }
    
    @discardableResult
    func verifyContentPageNavigation() -> Self {
        XCTAssertTrue(contentText.waitForExistence(timeout: 5), "Content text not found")
        XCTAssertTrue(backButton.waitForExistence(timeout: 5), "Back button not found")
        backButton.tap()
        
        return self
    }
    
    @discardableResult
    func tapBreakingNewsAndVerifyError() -> Self {
        XCTAssertTrue(homeFooterButton.waitForExistence(timeout: 5), "Breaking News button not found")
        homeFooterButton.tap()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5), "Alert did not appear")
        let okButton = alert.buttons["Ok"]
        XCTAssertTrue(okButton.exists, "Ok button not found in alert")
        okButton.tap()
        
        return self
    }
    
    @discardableResult
    func verifyStableAppState() -> Self {
        self.waitForPage()
        
        tagPicker.tap()
        let anyTopicOption = app.buttons.firstMatch
        XCTAssertTrue(anyTopicOption.waitForExistence(timeout: 5), "Topic Picker not interactable")
        
        return self
    }
}
