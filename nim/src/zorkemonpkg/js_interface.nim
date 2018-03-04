import interpreter/interpreter

var inpt = newInterpreter(@[newWord("go")])

proc parseInput(input: cstring): cstring {.exportc.} =
  return inpt.parse($input)
