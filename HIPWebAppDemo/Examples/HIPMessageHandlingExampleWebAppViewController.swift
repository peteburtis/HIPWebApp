//
//  HIPMessageHandlingExampleWebAppViewController.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import HIPWebApp


class HIPMessageHandlingExampleWebAppViewController: WebAppViewController, HIPMessageHandlingExampleWebAppDelegate {

    /// Convenience cast to expected web app class
    private var _messageHandlingWebApp: HIPMessageHandlingExampleWebApp? { return webApp as? HIPMessageHandlingExampleWebApp }

    override func createWebApp() -> WebApp? {
        let webApp = HIPMessageHandlingExampleWebApp()
        webApp.delegate = self
        return webApp
    }

    override func viewDidLoad() {
        self.loggingDelegate = BASIC_LOGGING

        super.viewDidLoad()

        self.loadURL(webApp!.initialURL)
    }

    /// Delegate method implementation
    func buttonWasClicked(data: AnyObject?) {
        NSLog("FIRE ZE MISSILES!!! Data: \(data)")
    }
}


//MARK: Actions
extension HIPMessageHandlingExampleWebAppViewController {
    @IBAction func redAction(sender: AnyObject? = nil) {
        _messageHandlingWebApp?.setButtonColor("red")
    }

    @IBAction func greenAction(sender: AnyObject? = nil) {
        _messageHandlingWebApp?.setButtonColor("green")
    }

    @IBAction func blueAction(sender: AnyObject? = nil) {
        _messageHandlingWebApp?.setButtonColor("blue")
    }
}