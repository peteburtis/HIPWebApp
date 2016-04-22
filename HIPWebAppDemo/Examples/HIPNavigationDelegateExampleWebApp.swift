//
//  HIPNavigationDelegateExampleWebApp.swift
//  HIPWebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


class HIPNavigationDelegateExampleWebApp: NSObject, HIPWebApp {  // WKNavigationDelegate requires NSObject
    var appIdentifier: String { return "navigation-delegate" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: HIPNavigationDelegateExampleWebApp.self)
        let htmlPath = bundle.pathForResource("HIPNavigationDelegateExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }
}


extension HIPNavigationDelegateExampleWebApp: HIPWebAppNavigating {
    func getWebViewNavigationDelegate() -> WKNavigationDelegate {
        return self
    }
}

extension HIPNavigationDelegateExampleWebApp: WKNavigationDelegate {
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.URL?.host?.containsString("slashdot") == true {
            NSLog("No slashdot for you!")
            decisionHandler(.Cancel)
        } else {
            decisionHandler(.Allow)
        }
    }
}