//
//  HIPMesssageHandlingExampleWebApp.swift
//  HIPWebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


protocol HIPMessageHandlingExampleWebAppDelegate: class {
    func buttonWasClicked(data: AnyObject?)
}


class HIPMessageHandlingExampleWebApp: NSObject, HIPWebApp, HIPWebViewReferencing, HIPWebAppMessageHandling {
    var appIdentifier: String { return "message-handling" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: HIPMessageHandlingExampleWebApp.self)
        let htmlPath = bundle.pathForResource("HIPMessageHandlingExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }

    weak var webView: WKWebView? = nil
    weak var delegate: HIPMessageHandlingExampleWebAppDelegate?

    func willRunInWebView(webView: WKWebView) {
        self.webView = webView
    }

    var supportedMessageNames: [String] { return ["BUTTON_CLICKED"] }

    func handleMessage(name: String, _ body: AnyObject) -> Bool {
        switch name {
        case "BUTTON_CLICKED": delegate?.buttonWasClicked(body)
        default: return false
        }
        return true
    }

    func setButtonColor(cssColorString: String) {
        webView?.evaluateJavaScript("window.containerAPI.changeButtonColor('\(cssColorString)');", completionHandler: nil)
    }
}
