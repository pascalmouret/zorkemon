import unittest
import fp/option

suite "OptionSpec":
  let nilVal: seq[int] = nil

  test "constructor procs":
    check(Some(1).nonEmpty)
    check(not Some(1).isEmpty)
    check(None(int).isEmpty)
    check(not None(int).nonEmpty)
    check(Some(nilVal).isEmpty)

  test "working getter":
    check(Some(1).get == 1)
    expect ValueError:
      let n = None(int).get
