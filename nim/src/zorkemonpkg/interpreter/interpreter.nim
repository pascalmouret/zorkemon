from strutils import splitWhitespace
import ../fp/option

type
  Word* = ref object
    value: string

  Interpreter* = ref object of RootObj
    words: seq[Word]

proc newInterpreter*(words: seq[Word]): Interpreter =
  return Interpreter(words: words)

proc newWord*(value: string): Word =
  return Word(value: value)

method wordForToken(self: Interpreter, token: string): Option[Word] {.base.} =
  for word in self.words:
    if word.value == token:
      return Some(word)
  return None(Word)

method parse*(self: Interpreter, input: string): string {.base.} =
  var col: seq[Word] = @[]
  for token in input.splitWhitespace():
    self.wordForToken(token).foreach(proc (w: Word): void = col.add(w))
  result = ""
  for word in col:
    result = result & word.value
