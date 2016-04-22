# HIPWebApp: WKWebView design patterns

At Hipmunk, we've been experimenting with ways to integrate web-based views into our app without providing a
bad experience for users. To us, that means tight integration between the code running in the web view and the
native parts of our app.

This framework removes a lot of boilerplate from the process of creating and configuring a `WKWebView`, and
encourages you to create a dedicated "web app" object whose only job is to be the interface between your web
code and your native code.

The source code comes with a few examples.
