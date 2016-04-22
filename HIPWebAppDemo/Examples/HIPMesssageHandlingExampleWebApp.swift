//
//  HIPMesssageHandlingExampleWebApp.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


/// Forward any WKWebView messages as delegate methods
protocol HIPMessageHandlingExampleWebAppDelegate: class {
    func buttonWasClicked(data: AnyObject?)
}


class HIPMessageHandlingExampleWebApp: WebApp {
    /// Included in log messages
    var appIdentifier: String { return "message-handling" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: HIPMessageHandlingExampleWebApp.self)
        let htmlPath = bundle.pathForResource("HIPMessageHandlingExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }

    weak var webView: WKWebView? = nil
    weak var delegate: HIPMessageHandlingExampleWebAppDelegate?
}


//MARK: External API
extension HIPMessageHandlingExampleWebApp {
    func setButtonColor(cssColorString: String) {
        webView?.evaluateJavaScript("window.containerAPI.changeButtonColor('\(cssColorString)');", completionHandler: nil)
    }
}


//MARK: Grab a reference to the web view
extension HIPMessageHandlingExampleWebApp: WebAppWebViewReferencing {
    func willRunInWebView(webView: WKWebView) {
        self.webView = webView
    }
}


//MARK: Handle WKWebView messages
extension HIPMessageHandlingExampleWebApp: WebAppMessageHandling {
    var supportedMessageNames: [String] { return ["BUTTON_CLICKED"] }

    func handleMessage(name: String, _ body: AnyObject) -> Bool {
        switch name {
        case "BUTTON_CLICKED": delegate?.buttonWasClicked(body)
        default: return false
        }
        return true
    }
}