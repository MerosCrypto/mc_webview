import os

version     = "0.2.0"
author      = "kayabaNerve (Luke Parker)"
description = "Nim bindings for WebView Org's WebView."
license     = "MIT"

requires "nim >= 1.2.10"

installDirs = @[
  "webview"
]

installFiles = @[
  "mc_webview.nim"
]
