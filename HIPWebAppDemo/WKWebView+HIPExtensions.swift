//
//  WKWebView+HIPExtensions.swift
//  Hipmunk
//
//  Created by Steve Johnson on 4/5/16.
//  Copyright © 2016 Hipmunk. All rights reserved.
//

import Foundation
import WebKit

extension WKWebView {
    /// Call a JS function inside the web view. All args must be JSON-serializable according to HIPJSUtil.encodeJSON().
    func hip_callJS(functionName: String, _ args: AnyObject...) {
        guard let functionCallString = HIPJSUtil.createJavaScriptFunctionCall(functionName, args) else {
            assertionFailure("Can't make a function call out of \(args)")
            return
        }
        evaluateJavaScript(functionCallString, completionHandler: {_ in })
    }

}