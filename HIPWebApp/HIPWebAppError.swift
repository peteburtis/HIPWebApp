//
//  HIPWebAppError.swift
//  Hipmunk
//
//  Created by Steve Johnson on 3/30/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation


/// All errors that can be thrown by `HIPWebAppViewController`
public enum HIPWebAppError: ErrorType {
    /// handleMessage() may throw this if it can't parse a message body.
    case MessageParseError
}