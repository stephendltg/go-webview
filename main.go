package main

import (
	"github.com/webview/webview"
)

func main() {
	debug := false
	w := webview.New(debug)
	defer w.Destroy()
	w.SetTitle("Minimal webview example")
	w.SetSize(800, 600, webview.HintNone)
	w.Navigate("http://82.165.110.160/apps/manager")
	/*
		w.Bind("noop", func() string {
			log.Println("hello")
			return "hello"
		})
		w.Bind("add", func(a, b int) int {
			return a + b
		})
		w.Navigate(`data:text/html,
			<!doctype html>
			<html>
				<body>hello</body>
				<script>
					window.onload = function() {
						document.body.innerText = ` + "`hello, ${navigator.userAgent}`" + `;
						noop().then(function(res) {
							console.log('noop res', res);
							add(1, 2).then(function(res) {
								console.log('add res', res);
							});
						});
					};
				</script>
			</html>
		)`)
	*/
	w.Run()
}
