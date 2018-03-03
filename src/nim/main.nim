import interpreter

var inpt = interpreter.Interpreter()

proc parseInput(input: cstring): cstring {.exportc.} =
  return inpt.parse($input)
