//
//  HIPExampleWebApp.swift
//  Hipmunk
//
//  Created by Steve Johnson on 3/7/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


class HIPExampleWebApp: NSObject, HIPWebApp, HIPWebViewReferencing {
    var appIdentifier: String { return "google" }
    var initialURL: NSURL { return NSURL(string: "https://google.com")! }

    weak var webView: WKWebView? = nil

    func willRunInWebView(webView: WKWebView) {
        self.webView = webView
    }
}
