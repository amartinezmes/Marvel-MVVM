//
//  MarvelUITests.swift
//  MarvelUITests
//
//  Created by Alex Martinez Mesa on 24/1/18.
//  Copyright © 2018 Alex Martinez Mesa. All rights reserved.
//

import XCTest

class MarvelUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    func testDetailSuperHero() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["test1"]/*[[".cells.staticTexts[\"test1\"]",".staticTexts[\"test1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testSearchSpiderMan() {
        
        let app = XCUIApplication()
        let searchYourSuperheroSearchField = app.searchFields["Search your superHero"]
        searchYourSuperheroSearchField.tap()
        searchYourSuperheroSearchField.typeText("Spider")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"Buscar\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["spider1"]/*[[".cells.staticTexts[\"spider1\"]",".staticTexts[\"spider1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    
    func testLayoutCollection() {
        
        let app = XCUIApplication()
        app.buttons["Layout"].tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.tap()
        
        let marvelSuperherodetailviewNavigationBar = app.navigationBars["Marvel.SuperHeroDetailView"]
        let backButton = marvelSuperherodetailviewNavigationBar.buttons["Back"]
        backButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        marvelSuperherodetailviewNavigationBar.tap()
        backButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.tap()
        backButton.tap()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 3).children(matching: .other).element.children(matching: .other).element.tap()
        backButton.tap()
        
    }
    
    func testDetailSuperHeroWithScroll() {
        let app = XCUIApplication()
        app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo"]/*[[".cells.staticTexts[\"Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo\"]",".staticTexts[\"Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.staticTexts["Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo. Description superlarga que debe provocar que se genera un scroll para poder probar dicho scroll que seguro que funcionará, pero es necesario esta prueba para saberlo"].swipeUp()

    }
    
}
