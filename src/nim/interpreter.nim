from strutils import splitWhitespace
import lib.option

type
  Word* = ref object
    value: string

  Interpreter* = ref object of RootObj
    words: seq[Word]

proc newInterpreter(words: seq[Word]): Interpreter =
  Interpreter(words: words)

method wordForToken(self: Interpreter, token: string): Option[Word] {.base.} =
  for word in self.words:
    if word.value == token:
      return Some(word)
  return None(Word)

method parse*(self: Interpreter, input: string): string {.base.} =
  var col: seq[Word] = @[]
  for token in input.splitWhitespace():
    let opt = self.wordForToken(token)
    if not opt.isEmpty:
      col.add(opt.get)
  result = ""
  for word in col:
    result = result & word.value


when isMainModule:
  let intpr = Interpreter(words: @[Word(value: "go"), Word(value: "north")])
  assert(intpr.parse("test input") == "")
  assert(intpr.parse("go north") == "gonorth")
  assert(intpr.parse("go west") == "go")
