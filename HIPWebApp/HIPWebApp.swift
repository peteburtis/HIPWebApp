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
 A `HIPWebApp` is an HTTP[S]-accessible location and a string identifier for logging. Optionally, it can also:

  - Store a reference to the `WKWebView` that hosts it
  - Provide a `WKWebViewConfiguration`
  - Provide a `WKWebViewNavigationDelegate`
  - Listen to `webkit.messageHandlers[name].postMessage(body)` calls
 
 To support these features, have a look at the other protocols starting with `HIPWebApp*`.
 
 Conceptually, a `HIPWebApp` represents your web application in native app code. It has sole responsibility for calling
 JavaScript in the page and receiving messages. A common pattern is to define a delegate and pass on messages as calls
 to the delegate.
 
 Simplest possible web app:
 
 ````swift
 class HIPSimplestExampleWebApp: HIPWebApp {
     var appIdentifier: String { return "google" }
     var initialURL: NSURL { return NSURL(string: "https://google.com")! }
 }
 ````

 */
public protocol HIPWebApp {
    /// Endpoint where this web app can be reached
    var initialURL: NSURL { get }

    /// Programmer-readable debug identifier for this web app
    var appIdentifier: String { get }
}


/// Add conformance to this protocol if your HIPWebApp provides a `WKWebViewConfiguration`.
public protocol HIPWebAppConfiguring {
    /// Attach message handlers and user scripts here
    func getWebViewConfiguration() -> WKWebViewConfiguration
}


/// Add conformance to this protocol if your HIPWebApp provides `WKNavigationDelegate`.
public protocol HIPWebAppNavigating {
    /// Handle or expose navigation events here
    func getWebViewNavigationDelegate() -> WKNavigationDelegate
}


/// Add conformance to this protocol if your `HIPWebApp` would like a reference to the `WKWebView` it runs in.
public protocol HIPWebAppWebViewReferencing {
    /// Perform any configuration not covered by the other protocol methods
    /// and/or grab a reference to the web view if you want it
    func willRunInWebView(webView: WKWebView) -> ()
}


/// Add conformance to this protocol if your `HIPWebApp` would like to listen to calls to
/// `webkit.messageHandlers[name].postMessage()`.
public protocol HIPWebAppMessageHandling {
    /// You must enumerate the names of the messages you want to receive.
    var supportedMessageNames: [String] { get }

    /// The web page has called messageHandlers[name].postMessage(body)
    func handleMessage(name: String, _ body: AnyObject) -> Bool
}
