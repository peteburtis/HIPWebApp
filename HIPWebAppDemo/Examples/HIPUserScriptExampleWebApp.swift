//
//  HIPUserScriptExampleWebApp.swift
//  WebAppDemo
//
//  Created by Steve Johnson on 4/22/16.
//  Copyright © 2016 Hipmunk, Inc. All rights reserved.
//

import Foundation
import WebKit
import HIPWebApp


class HIPUserScriptExampleWebApp: WebApp {
    var appIdentifier: String { return "user-script" }

    var initialURL: NSURL {
        let bundle = NSBundle(forClass: HIPUserScriptExampleWebApp.self)
        let htmlPath = bundle.pathForResource("HIPUserScriptExampleWebApp", ofType: "html")!
        return NSURL(fileURLWithPath: htmlPath)
    }
}


extension HIPUserScriptExampleWebApp: WebAppConfiguring {
    func getWebViewConfiguration() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()

        let userScript = (
            "document.body.innerHTML = '<h2>This markup was added by a user script</h2>';"
        )

        let content = WKUserContentController()
        let script = WKUserScript(source: userScript, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        content.addUserScript(script)
        config.userContentController = content

        return config
    }
}