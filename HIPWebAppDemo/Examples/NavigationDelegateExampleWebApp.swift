//
//  NavigationDelegateExampleWebApp.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


class NavigationDelegateExampleWebApp: NSObject, WebApp {  // WKNavigationDelegate requires NSObject
    var appIdentifier: String { return "navigation-delegate" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: NavigationDelegateExampleWebApp.self)
        let htmlPath = bundle.pathForResource("NavigationDelegateExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }
}


extension NavigationDelegateExampleWebApp: WebAppNavigating {
    func getWebViewNavigationDelegate() -> WKNavigationDelegate {
        return self
    }
}

extension NavigationDelegateExampleWebApp: WKNavigationDelegate {
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.URL?.host?.containsString("slashdot") == true {
            NSLog("No slashdot for you!")
            decisionHandler(.Cancel)
        } else {
            decisionHandler(.Allow)
        }
    }
}