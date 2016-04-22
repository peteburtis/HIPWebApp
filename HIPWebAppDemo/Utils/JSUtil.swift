//
//  JSUtil.swift
//  Hipmunk
//
//  Created by Steve Johnson on 3/30/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation


struct JSUtil {
    /// Simplest possible way to parse JSON coming from a trusted server
    static func parseJSONObjectWithoutHandlingErrors(s: String) -> NSDictionary? {
        guard let data = s.dataUsingEncoding(NSUTF8StringEncoding) else { return nil }
        guard let result = try? NSJSONSerialization.JSONObjectWithData(data, options: []) else { return nil }
        return result as? NSDictionary
    }

    /// Encode a dictionary, array, or value type (string, number, null) as a JSON string.
    static func encodeJSON(anything: AnyObject) -> String? {
        let options = NSJSONWritingOptions(rawValue: 0)

        // Surprisingly, JSON encoding doesn't work for non-collection types. To encode a number, you have to
        // wrap it in an array and chop off the square brackets!
        let isWrapped = NSJSONSerialization.isValidJSONObject([anything]) && !NSJSONSerialization.isValidJSONObject(anything)
        let object = isWrapped ? [anything] : anything

        guard NSJSONSerialization.isValidJSONObject(object) else { return nil }
        guard let data = try? NSJSONSerialization.dataWithJSONObject(object, options: options) else { return nil }
        guard let string = NSString(data: data, encoding: NSUTF8StringEncoding) as? String else { return nil }

        if isWrapped {
            return string.substringWithRange(string.startIndex.successor()..<string.endIndex.predecessor())
        } else {
            return string
        }
    }

    /// Create a string representing a JS function call.
    static func createJavaScriptFunctionCall(functionName: String, _ args: [AnyObject]) -> String? {
        let beginning = "\(functionName)("
        var argStrings = [String]()
        for arg in args {
            if let argString = encodeJSON(arg) {
                argStrings.append(argString)
            } else {
                assertionFailure("Could not encode argument \(arg)")
                return nil
            }
        }
        let argsString = argStrings.joinWithSeparator(", ")
        let end = ");"
        let s = beginning + argsString + end
        return s
    }

}