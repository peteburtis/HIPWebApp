//
//  WebAppError.swift
//  Hipmunk
//
//  Created by Steve Johnson on 3/30/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation


/// All errors that can be thrown by `WebAppViewController` subclasses and `WebApp` implementations
public enum WebAppError: ErrorType {
    /// Your `handleMessage(name:_:)` implementation may throw this if it can't parse a message body.
    case MessageParseError
}