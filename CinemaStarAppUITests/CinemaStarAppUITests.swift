//
//  CinemaStarAppUITests.swift
//  CinemaStarAppUITests
//
//  Created by Adlet Zhantassov on 27.04.2024.
//

import XCTest

final class CinemaStarAppUITests: XCTestCase {
    func testRunApp() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testCollection() throws {
        let app = XCUIApplication()
        app.launch()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier: "Земля\n⭐️ 8.3").element.swipeUp()
        cellsQuery.otherElements.containing(.staticText, identifier: "Демон революции\n⭐️ 6.2").element.swipeUp()
    }

    // swiftlint:disable all
    func testWatchButton() throws {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Земля\n⭐️ 8.3").element.tap()
        app.tables.staticTexts["Смотреть"].tap()
        app.alerts["Упс!"].scrollViews.otherElements.buttons["Ок"].tap()
    }

//     swiftlint:enable all

    func testFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier: "Земля\n⭐️ 8.3").element.tap()
        let cinemastarappDetailviewNavigationBar = app.navigationBars["CinemaStarApp.DetailView"]
        let unlikeButton = cinemastarappDetailviewNavigationBar.buttons["unlike"]
        unlikeButton.tap()
        unlikeButton.tap()
        cinemastarappDetailviewNavigationBar.buttons["Back"].tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
