//
//  UserScriptExampleWebAppViewController.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import HIPWebApp


class UserScriptExampleWebAppViewController: WebAppViewController {
    override func createWebApp() -> WebApp? { return UserScriptExampleWebApp() }

    override func viewDidLoad() {
        self.loggingDelegate = BASIC_LOGGING

        super.viewDidLoad()

        self.loadURL(webApp!.initialURL)
    }
}

