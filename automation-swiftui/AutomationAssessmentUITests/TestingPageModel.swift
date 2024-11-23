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
    var contentText: XCUIElement { app.staticTexts[AutomationIdentifiers.contentText.rawValue]}
    var backButton: XCUIElement { app.navigationBars.buttons.element(boundBy: 0)}
    
    private let standardTimeout: Double = 5
    
    // Test Steps
    @discardableResult
    func waitForPage() -> Self {
        
        // Verify that no loading indicators still exist on the page using HelperMethod
        let loadingIndicator = app.activityIndicators.firstMatch
        XCTAssertTrue(loadingIndicator.waitForNonExistence(timeout: standardTimeout), "Loading indicator did not disappear")
        
        // Check that all essential elements exist on the page using the helper method
        homeTitle.waitForElement(description: "HomeTitle", timeout: standardTimeout)
        homeSubtitle.waitForElement(description: "HomeSubtitle", timeout: standardTimeout)
        lastUpdated.waitForElement(description: "LastUpdated", timeout: standardTimeout)
        tagNavigation.waitForElement(description: "TagNavigation", timeout: standardTimeout)
        tagPicker.waitForElement(description: "TagPicker", timeout: standardTimeout)
        homeFooterButton.waitForElement(description: "HomeFooterButton", timeout: standardTimeout)
        
        return self
    }

    @discardableResult
    func verifyRefreshButtonUpdatesLastUpdated() -> Self {
        
        // Verify initial state
        lastUpdated.waitForElement(description: "LastUpdated", timeout: standardTimeout)
        let initialLastUpdated = lastUpdated.label
        refreshButton.waitForElement(description: "Refresh Button", timeout: standardTimeout)
        
        // Perform refresh
        refreshButton.tap()
        
        // Verify loading state and wait for completion using helper method
        let loadingIndicator = app.activityIndicators.firstMatch
        loadingIndicator.waitForElement(description: "Loading Indicator", timeout: standardTimeout)
        let loadingDisappeared = loadingIndicator.waitForNonExistance(timeout: standardTimeout)
        XCTAssertTrue(loadingDisappeared, "Loading indicator did not disappear within 5 seconds")
        
        // Verify updated state
        lastUpdated.waitForElement(description: "Last Updated after refresh", timeout: standardTimeout)
        let newLastUpdated = lastUpdated.label
        XCTAssertFalse(newLastUpdated.isEmpty, "New last updated time is empty")
        XCTAssertNotEqual(newLastUpdated, initialLastUpdated, "Last updated time did not change after refresh")
        
        return self
    }
    
    @discardableResult
    func verifyTopicSelection(topic: String) -> Self {
        
        // Find the Tag Picker
        tagPicker.waitForElement(description: "Tag Picker", timeout: standardTimeout)
        tagPicker.tap()
        
        // Select the Technology option
        let topicOption = app.buttons[topic]
        topicOption.waitForElement(description: "Topic Option", timeout: standardTimeout)
        topicOption.tap()
        
        return self
    }
    
    @discardableResult
    func verifyTechnologyContentNavigation() -> Self {
    
        // Verify content loaded
        contentText.waitForElement(description: "Content Text", timeout: standardTimeout)
        
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
        
        // Check that the backButton exists and navigate back
        self.backButtonTap()
        
        return self
    }
    
    @discardableResult
    func verifyAlertDialog(tapOption: String) -> Self {
        
        // Detect and verify the alert
        let alert = app.alerts.firstMatch
        alert.waitForElement(description: "Alert", timeout: standardTimeout)
        
        // Verify that the alert button has the correct option
        let button = alert.buttons[tapOption]
        XCTAssertTrue(button.exists, "\(tapOption) button not found in alert")
        button.tap()
        
        return self
        
    }
    
    @discardableResult
    func tagNavigationTap(topic: String) -> Self {
        
        // Verify that the tagNavigation has the correct label and click it
        XCTAssertTrue(tagNavigation.waitForExistence(timeout: standardTimeout), "Go to \(topic) link not found")
        XCTAssertEqual(tagNavigation.label, "Go to \(topic)", "Tag Navigation label has the incorrect text")
        tagNavigation.tap()
        
        return self
    }
    
    @discardableResult
    func backButtonTap() -> Self {
        
        // Verify that the backButton exists and click it
        backButton.waitForElement(description: "Back Button", timeout: standardTimeout)
        backButton.tap()
        
        return self
    }
    
    @discardableResult
    func verifyContentPageNavigation() -> Self {
        
        // Check that the contentText exists
        contentText.waitForElement(description: "Content Text", timeout: standardTimeout)
        
        // Check that the back button exists and click it
        self.backButtonTap()
        
        return self
    }
    
    @discardableResult
    func tapBreakingNewsAndVerifyError() -> Self {
        
        // Verify that the footer exists and click it
        homeFooterButton.waitForElement(description: "Home Footer Button", timeout: standardTimeout)
        homeFooterButton.tap()
        
        // Verify the alert has the correct label and click it using our earlier defined method
        self.verifyAlertDialog(tapOption: "Ok")
        
        return self
    }
    
    @discardableResult
    func verifyStableAppState() -> Self {
        
        // Check HomePage state is correct
        self.waitForPage()
        
        // Check that an element on the page is interactable
        tagPicker.tap()
        let anyTopicOption = app.buttons.firstMatch
        anyTopicOption.waitForElement(description: "Topic Picker", timeout: standardTimeout)
        
        return self
    }
}
