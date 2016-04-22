//
//  MessageHandlingExampleWebAppViewController.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import HIPWebApp


class MessageHandlingExampleWebAppViewController: WebAppViewController, MessageHandlingExampleWebAppDelegate {

    /// Convenience cast to expected web app class
    private var _messageHandlingWebApp: MessageHandlingExampleWebApp? { return webApp as? MessageHandlingExampleWebApp }

    override func createWebApp() -> WebApp? {
        let webApp = MessageHandlingExampleWebApp()
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
extension MessageHandlingExampleWebAppViewController {
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