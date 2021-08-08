# WEBVIEW GOLANG

It uses Cocoa/WebKit on macOS, gtk-webkit2 on Linux and Edge on Windows 10.

## USAGE

**GOLANG**

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

**Nodejs**

```
npm install --global .
```

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

**Deno**

```
deno install -f -A webviewd.ts
```

```
webviewd [options]

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

## Distributing webview apps

On Linux you get a standalone executable. It will depend on GTK3 and GtkWebkit2,
so if you distribute your app in DEB or RPM format include those dependencies.
An application icon can be specified by providing a .desktop file.

```linux
sudo apt-get install libwebkit2gtk-4.0-dev
```

## GENERATE DEBIAN PACKAGE

**ref:** http://sdz.tdct.org/sdz/creer-un-paquet-deb.html

**red:** https://github.com/practice-golang/hello-cmake

**ref:**
https://stackoverflow.com/questions/61507209/creating-a-go-binary-as-debian-binary-package-for-a-custom-repository

**ref:** https://gowebexamples.com/templates/

## INSTALL AND REMOVE DEB

```
sudo dpkg -i nom_du_paquet.deb
sudo apt-get remove nom_du_paquet
```
