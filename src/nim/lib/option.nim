type
  Option*[T] = ref object
    isEmpty*: bool
    value: T

proc None*[T](): Option[T] =
  return Option[T](isEmpty: true)

# if there is no `isNil` method, we just assume it's not...
proc isNil[T](v: T): bool =
  return false

proc Some*[T](value: T): Option[T] =
  if not value.isNil:
    return Option[T](value: value, isEmpty: false)
  else:
    return None[T]()

proc newOption*[T](value: T): Option[T]=
  return Some(value)

method get*[T](self: Option[T]): T {.base.} =
  if not self.isEmpty:
    return self.value
  else:
    raise newException(ValueError, "Tried to get empty Option.")

method nonEmpty*[T](self: Option[T]): bool {.base.} =
  return not self.isEmpty

when isMainModule:
  var test: seq[int]
  assert(Some(1).nonEmpty)
  assert(Some(test).isEmpty)
  assert(None[int]().isEmpty)
  assert(Some(1).get == 1)
  try:
    let n = None[int]().get
    assert(false)
  except ValueError:
    assert(true)
  except:
    assert(false)
