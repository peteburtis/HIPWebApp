//
//  WebAppViewControllerLoggingDelegate.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation


/**
 If you would like `WebAppViewController` to log debug and error information, implement this protocol in a class
 and set `myWebAppViewController.loggingDelegate` to it.
 */
public protocol WebAppViewControllerLoggingDelegate: class {
    /// Log a debug message.
    func debug(message: String)

    /// Log a generic message.
    func info(message: String)

    /// Log an error.
    func error(message: String)
}