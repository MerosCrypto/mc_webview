static:
  const WEBVIEW_DIR: string = currentSourcePath().substr(0, high(currentSourcePath()) - 14)
  discard staticExec "g++ --std=c++11 $(pkg-config --cflags gtk+-3.0 webkit2gtk-4.0) -c " & WEBVIEW_DIR & "webview/webview.cc"
  {.passL: WEBVIEW_DIR & "webview.o".}

  when defined(linux):
    #Required so the string is considered static.
    const libs: string = staticExec "pkg-config --libs gtk+-3.0 webkit2gtk-4.0"
    {.passL: libs.}
  elif defined(windows):
    when sizeof(int) == 4:
      {.passL: "-mwindows -L./dll/x86 -lwebview -lWebView2Loader".}
    elif sizeof(int) == 8:
      {.passL: "-mwindows -L./dll/x64 -lwebview -lWebView2Loader".}
    else:
      panic("WebView must be run on a 32-bit or 64-bit architecture.")
  elif defined(macosx):
    {.passL: "-framework WebKit".}

type SizeHint* = enum
  None = 0,
  Minimum = 1,
  Maximum = 2,
  Fixed = 3

type Webview* = pointer

proc newWebview*(
  debug: bool
): Webview {.importc: "webview_create".}

proc setTitle*(
  w: Webview,
  title: cstring
) {.importc: "webview_set_title".}

proc setSize*(
  w: Webview,
  width: cint,
  height: cint,
  hints: SizeHint
) {.importc: "webview_set_size".}

proc bindProc*(
  w: Webview,
  name: cstring,
  p: proc (
    id: cstring,
    jsonArgs: cstring,
    carriedArgs: pointer
  ) {.cdecl.},
  carriedArgs: pointer
) {.importc: "webview_bind".}

proc returnProc*(
  w: Webview,
  id: cstring,
  status: cint,
  resultJSON: cstring
) {.importc: "webview_return".}

proc navigate*(
  w: Webview,
  url: cstring
) {.importc: "webview_navigate".}

proc eval*(
  w: Webview,
  js: cstring
) {.importc: "webview_eval".}

proc dispatch*(
  w: Webview,
  fn: proc (
    w: Webview,
    arg: pointer
  ) {.cdecl.},
  arg: pointer
) {.importc: "webview_dispatch".}

proc run*(
  w: Webview
) {.importc: "webview_run".}

proc terminate*(
  w: Webview
) {.importc: "webview_terminate".}

proc destroy*(
  w: Webview
) {.importc: "webview_destroy".}
