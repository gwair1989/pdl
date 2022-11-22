//
//  LoanView_UITest.swift
//  pdl_UITests
//
//  Created by Oleksandr Khalypa on 12.09.2022.
//

import XCTest

class LoanView_UITest: XCTestCase {
    
    let app = XCUIApplication()
    let elementsQuery = XCUIApplication().scrollViews.otherElements

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    
    func test_LoanView_selectLoan_isOpenWebView() {
        let loanButton = app.tabBars["Tab Bar"].buttons["Loan"]
        let isLoanButtonExists =  loanButton.waitForExistence(timeout: 3)
        XCTAssertTrue(isLoanButtonExists)
        loanButton.tap()

        let slider1 = elementsQuery.sliders["SelectAmountSlider"]
        slider1.adjust(toNormalizedSliderPosition: 0.7)
        let sliderText1 =  elementsQuery.staticTexts["$3,600"]
        XCTAssertTrue(sliderText1.exists)
        
        
        let emailTextField = elementsQuery.textFields["emailTextField"]
        emailTextField.tap()
        emailTextField.typeText("zuza@yahoo.com")
        let validImageEmail = elementsQuery.images["validImageEmail"]
        XCTAssertTrue(validImageEmail.exists)
        
        
        let ssnTextField = elementsQuery.textFields["ssnTextField"]
        ssnTextField.tap()
        ssnTextField.typeText("1234")
        let validImageSnn = elementsQuery.images["validImageSnn"]
        XCTAssertTrue(validImageSnn.exists)
        
        
        
        let nextButton = app.buttons["nextButton"]
        XCTAssertTrue(nextButton.exists)
        nextButton.tap()
        
        let webview = app.webViews.firstMatch
        let webViewExists = webview.waitForExistence(timeout: 5)
        
        XCTAssertTrue(webViewExists)
        
        
    }


}
