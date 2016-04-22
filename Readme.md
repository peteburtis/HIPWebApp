# HIPWebApp: WKWebView design patterns

At Hipmunk, we've been experimenting with ways to integrate web-based views into our app without providing a
bad experience for users. To us, that means tight integration between the code running in the web view and the
native parts of our app.

This framework removes a lot of boilerplate from the process of creating and configuring a `WKWebView`, and
encourages you to create a dedicated "web app" object whose only job is to be the interface between your web
code and your native code.

The source code comes with a few examples.


## Usage

First, make a subclass of `HIPWebApp`. The only hard requirements are a string
identifier for logging (`appIdentifier`) and an initial URL.

```swift
import Foundation
import HIPWebApp


class HIPSimplestExampleWebApp: HIPWebApp {
    var appIdentifier: String { return "google" }
    var initialURL: NSURL { return NSURL(string: "https://google.com")! }
}
```

Then you need a subclass of `HIPWebAppViewController` to host it. Here is the
minimum viable subclass:


```swift
import UIKit
import HIPWebApp


class HIPSimplestExampleWebAppViewController: HIPWebAppViewController {

    override func createWebApp() -> HIPWebApp? { return HIPSimplestExampleWebApp() }

    override func viewDidLoad() {
        // optional: set self.loggingDelegate to enable logging

        super.viewDidLoad()

        self.loadURL(webApp!.initialURL)
    }

}
```

You are now done!

If you want to do more, you'll need to implement one or more of these
protocols:

* `HIPWebAppWebViewReferencing` gives you an opportunity to store a reference
  to the web view. While this is a very common thing to do, it isn't strictly
  necessary.
* `HIPWebAppConfiguring` lets you provide a `WKWebViewConfiguration`, meaning
  you can add user scripts and more.
* `HIPWebAppNavigating` lets you provide a navigation delegate.
* `HIPWebAppMessageHandling` lets you listen for calls to
  `messageHandlers[messageName].postMessage(messageBody)`.

See `HIPWebApp.swift` and the examples for details.

## Further reading

* [The official `WKWebView` docs](https://developer.apple.com/library/ios/documentation/WebKit/Reference/WKWebView_Ref/)
* [`WKWebView` at NSHipster](http://nshipster.com/wkwebkit/)
