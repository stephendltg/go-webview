#!/usr/bin/env node
var child_process = require("child_process");
var path = require("path");

var binaryPath;
if (process.platform === "win32") {
  binaryPath = path.join(__dirname, "bin", "webview-win32-amd64");
} else if (process.platform === "darwin") {
  binaryPath = path.join(__dirname, "bin", "webview-darwin-amd64");
} else if (process.platform === "linux") {
  binaryPath = path.join(__dirname, "bin", "webview-linux-amd64");
} else {
  throw new Error("Unsupported platform: " + process.platform);
}

try {
  child_process.execFileSync(binaryPath, process.argv.slice(2), {
    cwd: process.cwd(),
  });
} catch (err) {
  process.exitCode = 1;
}
