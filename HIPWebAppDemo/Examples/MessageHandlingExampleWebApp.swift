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
protocol MessageHandlingExampleWebAppDelegate: class {
    func buttonWasClicked(data: AnyObject?)
}


class MessageHandlingExampleWebApp: WebApp {
    /// Included in log messages
    var appIdentifier: String { return "message-handling" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: MessageHandlingExampleWebApp.self)
        let htmlPath = bundle.pathForResource("MessageHandlingExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }

    weak var webView: WKWebView? = nil
    weak var delegate: MessageHandlingExampleWebAppDelegate?
}


//MARK: External API
extension MessageHandlingExampleWebApp {
    func setButtonColor(cssColorString: String) {
        webView?.evaluateJavaScript("window.containerAPI.changeButtonColor('\(cssColorString)');", completionHandler: nil)
    }
}


//MARK: Grab a reference to the web view
extension MessageHandlingExampleWebApp: WebAppWebViewReferencing {
    func willRunInWebView(webView: WKWebView) {
        self.webView = webView
    }
}


//MARK: Handle WKWebView messages
extension MessageHandlingExampleWebApp: WebAppMessageHandling {
    var supportedMessageNames: [String] { return ["BUTTON_CLICKED"] }

    func handleMessage(name: String, _ body: AnyObject) -> Bool {
        switch name {
        case "BUTTON_CLICKED": delegate?.buttonWasClicked(body)
        default: return false
        }
        return true
    }
}