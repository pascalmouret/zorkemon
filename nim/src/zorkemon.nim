import zorkemonpkg/interpreter/interpreter

var inpt = newInterpreter(@[newWord("go")])

echo(inpt.parse("go west"))
