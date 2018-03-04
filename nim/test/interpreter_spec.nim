import unittest
import interpreter.interpreter

suite "InterpreterSpecs":
  let interpreter = interpreter.newInterpreter(@[newWord("go"), newWord("west")])

  test "parse known words":
    check(interpreter.parse("go west") == "gowest")
    check(interpreter.parse("some string") == "")
