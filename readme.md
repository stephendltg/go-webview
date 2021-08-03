# WEBVIEW GOLANG

It supports two-way JavaScript bindings (to call JavaScript from C/C++/Go and to call C/C++/Go from JavaScript).

It uses Cocoa/WebKit on macOS, gtk-webkit2 on Linux and Edge on Windows 10.

## USAGE

```
webview [options]

  --dir string
        path to serve (default ".")
  --url string
        instead of serving files, load this url
  --title string
        title of the webview window (default "webview")
  --width int
        width of the webview window (default 800)
  --height int
        height of the webview window (default 600)
```



##  Distributing webview apps

On Linux you get a standalone executable. It will depend on GTK3 and GtkWebkit2, so if you distribute your app in DEB or RPM format include those dependencies. An application icon can be specified by providing a .desktop file.

```linux
sudo apt-get install libwebkit2gtk-4.0-dev
```

## GENERATE DEBIAN PACKAGE

__ref:__ http://sdz.tdct.org/sdz/creer-un-paquet-deb.html

__red:__ https://github.com/practice-golang/hello-cmake

__ref:__ https://stackoverflow.com/questions/61507209/creating-a-go-binary-as-debian-binary-package-for-a-custom-repository

__ref:__ https://gowebexamples.com/templates/


## INSTALL AND REMOVE DEB

```
sudo dpkg -i nom_du_paquet.deb
sudo apt-get remove nom_du_paquet
```