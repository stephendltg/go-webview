# SKELETON WEBVIEW GOLANG

It supports two-way JavaScript bindings (to call JavaScript from C/C++/Go and to call C/C++/Go from JavaScript).

It uses Cocoa/WebKit on macOS, gtk-webkit2 on Linux and Edge on Windows 10.

##  Distributing webview apps

On Linux you get a standalone executable. It will depend on GTK3 and GtkWebkit2, so if you distribute your app in DEB or RPM format include those dependencies. An application icon can be specified by providing a .desktop file.

On MacOS you are likely to ship an app bundle. Make the following directory structure and just zip it:

example.app
└── Contents
    ├── Info.plist
    ├── MacOS
    |   └── example
    └── Resources
        └── example.icns
Here, Info.plist is a property list file and *.icns is a special icon format. You may convert PNG to icns online.

On Windows you probably would like to have a custom icon for your executable. It can be done by providing a resource file, compiling it and linking with it. Typically, windres utility is used to compile resources. Also, on Windows, webview.dll and WebView2Loader.dll must be placed into the same directory with your app executable.

Also, if you want to cross-compile your webview app - use xgo (https://github.com/karalabe/xgo).

