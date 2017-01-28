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

    var initialURL: URL {
        let bundle = Bundle(for: NavigationDelegateExampleWebApp.self)
        let htmlPath = bundle.path(forResource: "NavigationDelegateExampleWebApp", ofType: "html")!
        return URL(fileURLWithPath: htmlPath)
    }
}


extension NavigationDelegateExampleWebApp: WebAppNavigating {
    func getWebViewNavigationDelegate() -> WKNavigationDelegate {
        return self
    }
}

extension NavigationDelegateExampleWebApp: WKNavigationDelegate {



    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void){
        if navigationAction.request.url?.host?.contains("slashdot") == true {
            print("No slashdot for you!")
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}
