//
//  WebApp.swift
//  HTML5 Demo
//
//  Created by Steve Johnson on 7/20/15.
//  Copyright (c) 2015 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit


/**
 A `WebApp` is an HTTP[S]-accessible location and a string identifier for logging. Optionally, it can also:

  - Store a reference to the `WKWebView` that hosts it
  - Provide a `WKWebViewConfiguration`
  - Provide a `WKWebViewNavigationDelegate`
  - Listen to `webkit.messageHandlers[name].postMessage(body)` calls
 
 To support these features, have a look at the other protocols starting with `WebApp*`.
 
 Conceptually, a `WebApp` represents your web application in native app code. It has sole responsibility for calling
 JavaScript in the page and receiving messages. A common pattern is to define a delegate and pass on messages as calls
 to the delegate.
 
 Simplest possible web app:
 
 ````swift
 class SimplestExampleWebApp: WebApp {
     let appIdentifier = "google"
     let initialURL = NSURL(string: "https://google.com")!
 }
 ````

 */
public protocol WebApp {
    /// Endpoint where this web app can be reached
    var initialURL: URL { get }

    /// Programmer-readable debug identifier for this web app
    var appIdentifier: String { get }
}


/// Add conformance to this protocol if your WebApp provides a `WKWebViewConfiguration`.
public protocol WebAppConfiguring {
    /// Attach message handlers and user scripts here
    func getWebViewConfiguration() -> WKWebViewConfiguration
}


/// Add conformance to this protocol if your WebApp provides `WKNavigationDelegate`.
public protocol WebAppNavigating {
    /// Handle or expose navigation events here
    func getWebViewNavigationDelegate() -> WKNavigationDelegate
}


/// Add conformance to this protocol if your `WebApp` would like a reference to the `WKWebView` it runs in.
public protocol WebAppWebViewReferencing {
    /// Perform any configuration not covered by the other protocol methods
    /// and/or grab a reference to the web view if you want it
    func willRunInWebView(_ webView: WKWebView) -> ()
}


/// Add conformance to this protocol if your `WebApp` would like to listen to calls to
/// `webkit.messageHandlers[name].postMessage()`.
public protocol WebAppMessageHandling {
    /// You must enumerate the names of the messages you want to receive.
    var supportedMessageNames: [String] { get }

    /// The web page has called messageHandlers[name].postMessage(body)
    func handleMessage(_ name: String, _ body: Any?) -> Bool
}
