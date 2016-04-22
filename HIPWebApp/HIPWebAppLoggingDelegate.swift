//
//  HIPWebAppLoggingDelegate.swift
//  HIPWebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation


public protocol HIPWebAppLoggingDelegate: class {
    func debug(message: String)
    func info(message: String)
    func error(message: String)
}