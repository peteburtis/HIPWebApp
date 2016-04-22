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
 A WebAppViewController is the canonical way to show WebApps to users.

 Important note: unless you call ensureWebViewInstantiated(), the web app is not created until the view controller
 is added to the view hierarchy! If you want to start loading the page before you show it to the user, call that
 method.
 
 Simplest possible view controller:

 ````swift
 class SimplestExampleWebAppViewController: WebAppViewController {

     override func createWebApp() -> WebApp { return SimplestExampleWebApp() }

     override func viewDidLoad() {
         // optional:
         // self.loggingDelegate = myWebAppViewControllerLoggingDelegate

         super.viewDidLoad()
         self.loadWebAppInitialURL()
     }

 }
 ````
 */
public class WebAppViewController: UIViewController, WKScriptMessageHandler {
    /// WebApp's classes will be silent in the console unless you set this.
    public weak var loggingDelegate: WebAppViewControllerLoggingDelegate?

    /// The `WKWebView` instance created by this view controller, if it exists yet
    public var webView: WKWebView?

    /// The `WebApp` instance created by this view controller, if it exists yet
    public var webApp: WebApp?

    private var _webAppConfiguring: WebAppConfiguring? { return webApp as? WebAppConfiguring }
    private var _webAppNavigating: WebAppNavigating? { return webApp as? WebAppNavigating }
    private var _webViewReferencing: WebAppWebViewReferencing? { return webApp as? WebAppWebViewReferencing }
    private var _webViewMessageHandling: WebAppMessageHandling? { return webApp as? WebAppMessageHandling }

    /// The web view will be added as a subview of this, sharing its constraints. Defaults to `self.view`.
    @IBOutlet private var webViewContainer: UIView?

    /// WebApp creates the navigation delegate, but we store it here so that every WebApp doesn't have to remember
    /// to do so (it's a weak ref on the web view).
    private var webViewNavigationDelegate: WKNavigationDelegate?

    /// Subclasses must return a WebApp instance from this method. Unless you're doing something sophisticated, the
    /// WebApp instance should generally not be created until this method is called, since the view may not be visible
    /// yet and we want to minimize memory usage.
    ///
    /// It's a method rather than a closure passed to init() because complex uses of WebAppViewController should
    /// probably be subclassing it anyway.
    public func createWebApp() -> WebApp {
        preconditionFailure("You must subclass WebAppViewController and override this method.")
    }

    /// Create and configure the WKWebView using the WebApp (don't add it to the view hierarchy yet)
    private func createWebView() -> WKWebView {
        let configuration: WKWebViewConfiguration = _webAppConfiguring?.getWebViewConfiguration() ?? WKWebViewConfiguration()

        // WebApp automatically conforms to WKScriptMessageHandler
        for messageName in _webViewMessageHandling?.supportedMessageNames ?? [] {
            configuration.userContentController.addScriptMessageHandler(self, name: messageName)
        }

        let _webView = WKWebView(frame: self.view.frame, configuration: configuration)
        webViewNavigationDelegate = _webAppNavigating?.getWebViewNavigationDelegate()
        _webView.navigationDelegate = webViewNavigationDelegate
        _webView.opaque = false
        return _webView
    }

    override public func loadView() {
        webApp = createWebApp()

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

    /// Load the initial URL specified in the web app. You'll probably want to call this from `viewDidLoad()`.
    public func loadWebAppInitialURL() {
        guard let webApp = webApp else {
            assertionFailure("Can't load web app's initial URL because we don't have one yet")
            return
        }
        loadURL(webApp.initialURL)
    }

    internal func loadURL(url: NSURL) {
        webView!.loadRequest(NSURLRequest(URL: url))
    }

    /// Make sure the WebApp and WKWebView have been instantiated and configured
    public func ensureWebViewInstantiated() {
        _ = self.view  // loadView is lazy, and that's where we instantiate the web view
    }

    /// WKScriptMessageHandler implementation
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
