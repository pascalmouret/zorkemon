type
  Option*[T] = ref object
    isEmpty*: bool
    value: T

proc None*(T: typedesc): Option[T] =
  return Option[T](isEmpty: true)

# if there is no `isNil` method, we just assume it's not...
proc isNil[T](v: T): bool =
  return false

proc Some*[T](value: T): Option[T] =
  if not value.isNil:
    return Option[T](value: value, isEmpty: false)
  else:
    return None(T)

proc newOption*[T](value: T): Option[T]=
  return Some(value)

method get*[T](self: Option[T]): T {.base.} =
  if not self.isEmpty:
    return self.value
  else:
    raise newException(ValueError, "Tried to get empty Option.")

method nonEmpty*[T](self: Option[T]): bool {.base.} =
  return not self.isEmpty

method flatMap*[T, N](self: Option[T], f: proc (t: T): Option[N]): Option[N] {.base.} =
  if self.nonEmpty:
    return f(self.value)
  else:
    return None(N)

method map*[T, N](self: Option[T], f: proc (t: T): N): Option[N] {.base.} =
  return self.flatMap(proc(t: T): Option[N] = Some(f(t)))

method foreach*[T](self: Option[T], f: proc (t: T): void): void {.base.} =
  if self.nonEmpty:
    f(self.get)
