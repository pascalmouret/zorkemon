from strutils import splitWhitespace

type Interpreter* = ref object of RootObj

method parse*(interpreter: Interpreter, input: string): string {.base.} =
  result = ""
  for token in input.splitWhitespace():
    result = result & token

when isMainModule:
  var intpr = Interpreter()
  echo intpr.parse("test input")
