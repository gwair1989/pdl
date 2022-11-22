//
//  CalculatorView_UITests.swift
//  pdl_UITests
//
//  Created by Oleksandr Khalypa on 08.09.2022.
//

import XCTest

class CalculatorView_UITests: XCTestCase {
    
    let app = XCUIApplication()
    let elementsQuery = XCUIApplication().scrollViews.otherElements

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
    }

    
    
    func test_CalculatorView_LoanAmountSlider_isSetTitle() {

        app.tabBars["Tab Bar"].buttons["Calculator"].tap()

        let slider1 = elementsQuery.sliders["LoanAmountSlider"]
        slider1.adjust(toNormalizedSliderPosition: 0.9)
        let sliderText1 =  elementsQuery.staticTexts["$4,600"]
        XCTAssertTrue(sliderText1.exists)
        
        
        let slider2 = elementsQuery.sliders["InterestRateSlider"]
        slider2.adjust(toNormalizedSliderPosition: 0.2)
        let slider2Text = elementsQuery.staticTexts["19%"]
        XCTAssertTrue(elementsQuery.staticTexts["$1130"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["$20332"].exists)
        XCTAssertTrue(slider2Text.exists)

        
        let slider3 = elementsQuery.sliders["LoanTermInMonthSlider"]
        slider3.adjust(toNormalizedSliderPosition: 0.33)
        let slider3Text = elementsQuery.staticTexts["12"]
        XCTAssertTrue(elementsQuery.staticTexts["$1257"].exists)
        XCTAssertTrue( elementsQuery.staticTexts["$15088"].exists)
        XCTAssertTrue(slider3Text.exists)
        
        
        slider1.adjust(toNormalizedSliderPosition: 0.2)
        let slider4Text =  elementsQuery.staticTexts["$1,000"]
        XCTAssertTrue(elementsQuery.staticTexts["$273"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["$3280"].exists)
        XCTAssertTrue(slider4Text.exists)
        
        
        slider2.adjust(toNormalizedSliderPosition: 0.33)
        let slider5Text = elementsQuery.staticTexts["34%"]
        XCTAssertTrue(elementsQuery.staticTexts["$423"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["$5080"].exists)
        XCTAssertTrue(slider5Text.exists)

        
        slider3.adjust(toNormalizedSliderPosition: 0.9)
        let slider6Text = elementsQuery.staticTexts["33"]
        XCTAssertTrue(elementsQuery.staticTexts["$370"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["$12220"].exists)
        XCTAssertTrue(slider6Text.exists)
        

    }
    
    
    
    
}




// Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
// Naming Structure: test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then
