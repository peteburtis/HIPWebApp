//
//  HIPWebApp.swift
//  HTML5 Demo
//
//  Created by Steve Johnson on 7/20/15.
//  Copyright (c) 2015 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit


/**
 * A HIPWebApp is:
 *  - An HTTP[S]-accessible location
 *  - A WKWebView configuration written to interact with the JavaScript in that location
 *  - A source of events from and information about the web page
 *  - An interface to send information and events to the web page
 *
 * A web app will commonly have:
 *  - User script injections
 *  - Message handlers
 *  - Evented properties or event sources derived from messages
 *  - Methods taking nice Swifty args that marshal them to JS and execute them in the web view
 *  - Arbitrary WKWebView customization that does _not_ include adding UIKit components
 *    (that's handled by HIPWebAppViewController subclasses)
 */
protocol HIPWebApp {
    /// Endpoint where this web app can be reached
    var initialURL: NSURL { get }

    /// Programmer-readable debug identifier for this web app
    var appIdentifier: String { get }
}


/// Add conformance to this protocol if your HIPWebApp provides a WKWebViewConfiguration.
protocol HIPWebAppConfiguring {
    /// Attach message handlers and user scripts here
    func getWebViewConfiguration() -> WKWebViewConfiguration
}


/// Add conformance to this protocol if your HIPWebApp provides WKNavigationDelegate.
protocol HIPWebAppNavigating {
    /// Handle or expose navigation events here
    func getWebViewNavigationDelegate() -> WKNavigationDelegate
}


/// Add conformance to this protocol if your HIPWebApp would like a reference to the WKWebView it runs in.
protocol HIPWebViewReferencing {
    /// Perform any configuration not covered by the other protocol methods
    /// and/or grab a reference to the web view if you want it
    func willRunInWebView(webView: WKWebView) -> ()
}


/// Add conformance to this protocol if your HIPWebApp would like to receive webkit.messageHandlers[name].postMessage()s.
protocol HIPWebAppMessageHandling {
    /// You must enumerate the names of the messages you want to receive.
    var supportedMessageNames: [String] { get }

    /// The web page has called messageHandlers[name].postMessage(body)
    func handleMessage(name: String, _ body: AnyObject) -> Bool
}
