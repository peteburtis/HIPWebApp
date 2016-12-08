//
//  HIPWebAppTests.swift
//  HIPWebAppTests
//
//  Created by Steve Johnson on 4/25/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import XCTest
import WebKit
import HIPWebApp


/// Web app with a configurable URL and AtDocumentStart user script that remembers what messages it has received
class TestableWebApp: WebApp, WebAppMessageHandling, WebAppConfiguring, WebAppWebViewReferencing {
    var onMessageReceived: (((String, Any)) -> Void)?

    let appIdentifier = "testable-web-app"
    let initialURL: URL
    let userScript: String?

    var webView: WKWebView?

    init(initialURL: URL, userScript: String? = nil) {
        self.initialURL = initialURL
        self.userScript = userScript
    }

    func willRunInWebView(_ webView: WKWebView) {
        self.webView = webView
    }

    var supportedMessageNames: [String] { return ["API_READY"] }

    func handleMessage(_ name: String, _ body: Any) -> Bool {
        onMessageReceived?((name, body))
        return true
    }

    func getWebViewConfiguration() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()

        if let userScript = userScript {
            let content = WKUserContentController()
            let script = WKUserScript(source: userScript, injectionTime: .atDocumentStart, forMainFrameOnly: true)
            content.addUserScript(script)
            config.userContentController = content
        }

        return config
    }
}


class HIPBareBonesWebAppViewController: WebAppViewController {
    fileprivate var _createWebApp: (() -> WebApp)! = nil

    convenience init(createWebApp: (() -> WebApp)) {
        self.init()
        _createWebApp = createWebApp
    }

    override func createWebApp() -> WebApp {
        return _createWebApp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadWebAppInitialURL()
    }
}


class HIPWebAppTests: XCTestCase {
    var bundle: Bundle! = nil

    override func setUp() {
        super.setUp()
        bundle = Bundle(for: HIPWebAppTests.self)
    }

    /// Make sure we can load a page, call some JS on it, and receive a message back
    func testMessages() {
        let htmlPath = bundle.path(forResource: "test_web_app", ofType: "html")!
        let app = TestableWebApp(initialURL: URL(fileURLWithPath: htmlPath), userScript: "window.webkit.messageHandlers.API_READY.postMessage('hello');")

        let vc = HIPBareBonesWebAppViewController(createWebApp: { app })
        vc.ensureWebViewInstantiated()
        XCTAssertNotNil(app.webView)

        let messageReceivedExpectation = expectation(description: "Received API_READY message")

        app.onMessageReceived = {
            let expected: (String, String) = ("API_READY", "hello")
            XCTAssertEqual($0.0, expected.0)
            XCTAssertEqual($0.1 as? String, expected.1)
            messageReceivedExpectation.fulfill()
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
