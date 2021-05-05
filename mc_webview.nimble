import os

version     = "0.2.0"
author      = "kayabaNerve (Luke Parker)"
description = "Nim bindings for WebView Org's WebView."
license     = "MIT"

requires "nim >= 1.2.10"

installFiles = @[
  "mc_webview.nim",
  "webview.o"
]

before install:
  exec "g++ --std=c++11 $(pkg-config --cflags gtk+-3.0 webkit2gtk-4.0) -c " & (thisDir() / "webview/webview.cc")
