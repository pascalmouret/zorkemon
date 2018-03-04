import strUtils

# Package

version       = "0.0.1"
author        = "Pascal Mouret"
description   = "A Zork like parody of Pokemon Go."
license       = "MIT"
srcDir        = "nim/src"
bin           = @["zorkemon"]

# Dependencies

requires "nim >= 0.18.0"

# Tasks

task build_web, "Build a web version.":
  exec "rm -rf ./target/web"
  exec "mkdir -p ./target"
  exec "cp -r ./web/ ./target/web"
  exec "nim js --out:./target/web/js_interface.js ./nim/src/zorkemonpkg/js_interface.nim"

after build:
  exec "mkdir -p ./target/bin"
  exec "mv ./zorkemon ./target/bin/zorkemon"

proc walkDir(dir: string, f: proc (f: string): void): void =
  let
    files = listFiles(dir)
    dirs = listDirs(dir)
  for file in files:
    f(file)
  for dir in dirs:
    walkDir(dir, f)

task test, "Run all tests":
  walkDir(
    thisDir() & "/nim/test",
    proc(f: string): void =
      if f.endsWith("_spec.nim"):
        echo f
        exec "nim c -r --hints:off " & f
        exec "rm " & f.replace(".nim")
  )
