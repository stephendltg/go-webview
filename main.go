package main

import (
	"log"

	"github.com/webview/webview"
)

func main() {
	debug := true
	w := webview.New(debug)
	defer w.Destroy()
	w.SetTitle("Minimal webview example")
	w.SetSize(800, 600, webview.HintNone)
	// w.Navigate("http://82.165.110.160/apps/manager")

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
				<head>
					<meta charset="UTF-8">
					<meta http-equiv="X-UA-Compatible" content="IE=edge">
					<meta name="viewport" content="width=device-width, initial-scale=1.0">
					<style>
					body {
						background-color: red;
					}
					</style>
					<script src="https://polyfill.io/v3/polyfill.min.js?features=es6%2Ces7%2es5"></script>
					<title>Document</title>
				</head>
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

	w.Run()
}
