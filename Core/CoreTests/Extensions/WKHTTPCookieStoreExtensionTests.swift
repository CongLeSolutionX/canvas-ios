//
// This file is part of Canvas.
// Copyright (C) 2024-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

@testable import Core
import WebKit
import XCTest

class WKHTTPCookieStoreExtensionTests: XCTestCase {
    private var webViewConfiguration: WKWebViewConfiguration!
    private let cookie = HTTPCookie.make()

    override func setUp() {
        super.setUp()
        webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.websiteDataStore = .nonPersistent()
    }

    func testGetAllCookies() {
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        let cookieWasSet = expectation(description: "Cookie was set.")
        cookieStore.setCookie(cookie) {
            cookieWasSet.fulfill()
        }
        wait(for: [cookieWasSet], timeout: 10)

        // WHEN
        let publisher = cookieStore.getAllCookies()

        // THEN
        XCTAssertSingleOutputEquals(
            publisher,
            [cookie],
            timeout: 10
        )
    }

    func testSetCookie() {
        let webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        XCTAssertSingleOutputEquals(
            cookieStore.getAllCookies(),
            [],
            timeout: 10
        )

        // WHEN
        XCTAssertFinish(cookieStore.setCookie(cookie))

        // THEN
        XCTAssertSingleOutputEquals(
            cookieStore.getAllCookies(),
            [cookie],
            timeout: 10
        )
    }

    func testDeleteAllCookies() {
        let webView = WKWebView(
            frame: .zero,
            configuration: webViewConfiguration
        )
        let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
        XCTAssertFinish(cookieStore.setCookie(cookie), timeout: 10)

        // WHEN
        XCTAssertFinish(cookieStore.deleteAllCookies())

        // THEN
        XCTAssertSingleOutputEquals(
            cookieStore.getAllCookies(),
            [],
            timeout: 10
        )
    }
}