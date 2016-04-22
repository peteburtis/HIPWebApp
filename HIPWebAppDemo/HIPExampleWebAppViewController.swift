//
//  HIPExampleWebAppViewController.swift
//  HIPWebAppDemo
//
//  Created by Steve Johnson on 4/6/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import UIKit

class HIPBasicLogging: HIPWebAppLoggingDelegate {
    func debug(message: String) {
        print("DEBUG: \(message)")
    }

    func info(message: String) {
        print("INFO: \(message)")
    }

    func error(message: String) {
        print("ERROR: \(message)")
    }
}
let _logging = HIPBasicLogging()

class HIPExampleWebAppViewController: HIPWebAppViewController {

    override func createWebApp() -> HIPWebApp? {
        return HIPExampleWebApp()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loggingDelegate = _logging
        self.loadURL(webApp!.initialURL)
    }
}

