//
//  SimplestExampleWebApp.swift
//  Hipmunk
//
//  Created by Steve Johnson on 3/7/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation
import HIPWebApp


class SimplestExampleWebApp: WebApp {
    var appIdentifier: String { return "google" }
    var initialURL: NSURL { return NSURL(string: "https://google.com")! }
}
