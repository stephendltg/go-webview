package main

import (
	"flag"
	"fmt"
	"net"
	"net/http"
	"os"
	"path/filepath"
	"strings"

	"github.com/webview/webview"
)

// Vars cli
var (
	title  = flag.String("title", "default", "Webview title")
	debug  = flag.Bool("debug", false, "Mode debug")
	height = flag.Int("height", 600, "Webview height")
	width  = flag.Int("width", 800, "Webview width")
	url    = flag.String("url", "", "Naviagte to this url")
	dir    = flag.String("dir", ".", "path to serve")
)

// Init
func init() {

	// Parse cli
	flag.Parse()

}

// Get port available
func getport() (int, net.Listener) {
	listener, err := net.Listen("tcp", ":0")
	if err != nil {
		panic(err)
	}

	port := listener.Addr().(*net.TCPAddr).Port

	return port, listener
}

// Handle http server
func handle(fs http.Handler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Add("Referrer-Policy", "0")
		// Cache
		w.Header().Add("Surrogate-Control", "no-store")
		w.Header().Add("Cache-Control", "no-store, no-cache, must-revalidate, proxy-revalidate")
		w.Header().Add("Pragma", "no-cache")
		w.Header().Add("Expires", "0")
		// Security
		w.Header().Add("X-Content-Type-Options", "nosniff")
		w.Header().Add("X-DNS-Prefetch-Control", "off")
		w.Header().Add("X-Frame-Options", "DENY")
		w.Header().Add("Strict-Transport-Security", "5184000")
		w.Header().Add("X-Download-Options", "noopen")
		w.Header().Add("X-XSS-Protection", "1; mode=block")

		fs.ServeHTTP(w, r)
	}
}

// static server
func fileServer(listener net.Listener, path string) {
	http.Handle("/", handle(http.FileServer(http.Dir(path))))
	panic(http.Serve(listener, nil))
}

// Absolu path exec
func abspath() string {
	exe, err := os.Executable()
	if err != nil {
		panic(err)
	}
	exe, err = filepath.EvalSymlinks(exe)
	if err != nil {
		panic(err)
	}
	dir := filepath.Dir(exe)
	return dir
}

// Run webview
func runWebview(url string, title string, width int, height int, debug bool) {
	w := webview.New(debug)
	defer w.Destroy()
	w.SetTitle(title)
	w.SetSize(width, height, webview.HintNone)
	w.Navigate(url)
	// Func close webview for js
	w.Bind("close", func() {
		os.Exit(0)
	})
	w.Run()
}

func main() {

	port, listener := getport()

	var path string
	if strings.HasPrefix(*dir, "./") || strings.HasPrefix(*dir, "../") || strings.HasPrefix(*dir, ".\\") || strings.HasPrefix(*dir, "..\\") {
		path = filepath.Join(abspath(), *dir)
	} else {
		path = *dir
	}

	if *url == "" {
		go fileServer(listener, path)
		url := fmt.Sprintf("http://localhost:%d/", port)
		runWebview(url, *title, *width, *height, *debug)
	} else {
		runWebview(*url, *title, *width, *height, *debug)
	}
}
