#!/usr/bin/env node
var child_process = require("child_process");
var path = require("path");

var binaryPath;
if (process.platform === "win32") {
  throw new Error(
    "Unsupported platform: " + process.platform + " Cooming soon!",
  );
} else if (process.platform === "darwin") {
  throw new Error(
    "Unsupported platform: " + process.platform + " Cooming soon!",
  );
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
