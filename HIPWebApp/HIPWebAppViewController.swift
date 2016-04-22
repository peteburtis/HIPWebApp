//
//  HIPAppWebViewController.swift
//  HTML5 Demo
//
//  Created by Steve Johnson on 7/20/15.
//  Copyright (c) 2015 Hipmunk, Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit


/**
 A HIPWebAppViewController is the canonical way to show HIPWebApps to users.

 Important note: unless you call ensureWebViewInstantiated(), the web app is not created until the view controller
 is added to the view hierarchy! If you want to start loading the page before you show it to the user, call that
 method.
 
 Simplest possible view controller:

 ````swift
 class HIPSimplestExampleWebAppViewController: HIPWebAppViewController {

     override func createWebApp() -> HIPWebApp? { return HIPSimplestExampleWebApp() }

     override func viewDidLoad() {
         // optional:
         // self.loggingDelegate = myLoggingDelegate

         super.viewDidLoad()
         self.loadURL(webApp!.initialURL)
     }

 }
 ````
 */
public class HIPWebAppViewController: UIViewController, WKScriptMessageHandler {
    /// HIPWebApp's classes will be silent in the console unless you set this.
    public weak var loggingDelegate: HIPWebAppLoggingDelegate?

    public var webView: WKWebView?
    public var webApp: HIPWebApp?

    private var _webAppConfiguring: HIPWebAppConfiguring? { return webApp as? HIPWebAppConfiguring }
    private var _webAppNavigating: HIPWebAppNavigating? { return webApp as? HIPWebAppNavigating }
    private var _webViewReferencing: HIPWebAppWebViewReferencing? { return webApp as? HIPWebAppWebViewReferencing }
    private var _webViewMessageHandling: HIPWebAppMessageHandling? { return webApp as? HIPWebAppMessageHandling }

    /// The web view will be added as a subview of this, sharing its constraints. Defaults to `self.view`.
    @IBOutlet private var webViewContainer: UIView?

    /// HIPWebApp creates the navigation delegate, but we store it here so that every HIPWebApp doesn't have to remember
    /// to do so (it's a weak ref on the web view).
    private var webViewNavigationDelegate: WKNavigationDelegate?

    /// Subclasses must return a HIPWebApp instance from this method. Unless you're doing something sophisticated, the
    /// HIPWebApp instance should generally not be created until this method is called, since the view may not be visible
    /// yet and we want to minimize memory usage.
    ///
    /// It's a method rather than a closure passed to init() because complex uses of HIPWebAppViewController should
    /// probably be subclassing it anyway.
    public func createWebApp() -> HIPWebApp? { assert(false, "Must override createWebApp()"); return nil }

    /// Create and configure the WKWebView using the HIPWebApp (don't add it to the view hierarchy yet)
    private func createWebView() -> WKWebView {
        let configuration: WKWebViewConfiguration = _webAppConfiguring?.getWebViewConfiguration() ?? WKWebViewConfiguration()

        // HIPWebApp automatically conforms to WKScriptMessageHandler
        for messageName in _webViewMessageHandling?.supportedMessageNames ?? [] {
            configuration.userContentController.addScriptMessageHandler(self, name: messageName)
        }

        let _webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webViewNavigationDelegate = _webAppNavigating?.getWebViewNavigationDelegate()
        _webView.navigationDelegate = webViewNavigationDelegate
        _webView.opaque = false
        return _webView
    }

    /// Create the views and HIPWebApp
    override public func loadView() {
        webApp = createWebApp()!

        super.loadView()

        let webView = createWebView()
        self.webView = webView
        _webViewReferencing?.willRunInWebView(webView)
        // don't let it create its own autolayout rules
        webView.translatesAutoresizingMaskIntoConstraints = false

        webViewContainer = webViewContainer ?? self.view

        webViewContainer!.insertSubview(webView, atIndex: 0)  // put it under everything so you can add chrome

        webViewContainer!.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|[webView]|", options: [], metrics: nil, views: ["webView": webView]))
        webViewContainer!.addConstraints(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|[webView]|", options: [], metrics: nil, views: ["webView": webView]))
    }

    /// Perform a GET request for the given URL in the web view
    public func loadURL(url: NSURL) {
        webView!.loadRequest(NSURLRequest(URL: url))
    }

    /// Make sure the HIPWebApp and WKWebView have been instantiated and configured
    public func ensureWebViewInstantiated() {
        _ = self.view  // loadView is lazy, and that's where we instantiate the web view
    }

    public func userContentController(
        userContentController: WKUserContentController,
        didReceiveScriptMessage message: WKScriptMessage)
    {
        if let supportedMessageNames = _webViewMessageHandling?.supportedMessageNames {
            guard supportedMessageNames.contains(message.name) else {
                // totally non-fatal to the app but certainly unexpected
                loggingDelegate?.error("\(webApp!.appIdentifier): Unknown message: \(message.name)")
                return
            }
        }

        loggingDelegate?.debug("\(webApp!.appIdentifier): Received message: \(message.name)")

        if _webViewMessageHandling?.handleMessage(message.name, message.body) == false {
            loggingDelegate?.error("\(webApp!.appIdentifier): Could not parse contents of message \(message.name): \(message.body)")
        }
    }
}
