//
//  HIPBasicLogging.swift
//  HIPWebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import HIPWebApp


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
let BASIC_LOGGING = HIPBasicLogging()