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
    fileprivate var _messageHandlingWebApp: MessageHandlingExampleWebApp? { return webApp as? MessageHandlingExampleWebApp }

    override func createWebApp() -> WebApp {
        let webApp = MessageHandlingExampleWebApp()
        webApp.delegate = self
        return webApp
    }

    override func viewDidLoad() {
        self.loggingDelegate = BASIC_LOGGING

        super.viewDidLoad()

        self.loadWebAppInitialURL()
    }

    /// Delegate method implementation
    func buttonWasClicked(data: Any?) {
        NSLog("FIRE ZE MISSILES!!! Data: \(data)")
    }
}


//MARK: Actions
extension MessageHandlingExampleWebAppViewController {
    @IBAction func redAction(sender: Any? = nil) {
        _messageHandlingWebApp?.setButtonColor(cssColorString: "red")
    }

    @IBAction func greenAction(sender: Any? = nil) {
        _messageHandlingWebApp?.setButtonColor(cssColorString: "green")
    }

    @IBAction func blueAction(sender: Any? = nil) {
        _messageHandlingWebApp?.setButtonColor(cssColorString: "blue")
    }
}
