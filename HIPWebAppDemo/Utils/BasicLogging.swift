//
//  BasicLogging.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import HIPWebApp


class BasicLogging: WebAppViewControllerLoggingDelegate {
    func debug(_ message: String) {
        print("DEBUG: \(message)")
    }

    func info(_ message: String) {
        print("INFO: \(message)")
    }

    func error(_ message: String) {
        print("ERROR: \(message)")
    }
}
let BASIC_LOGGING = BasicLogging()
