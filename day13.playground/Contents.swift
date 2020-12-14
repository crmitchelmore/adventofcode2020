import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
  func characters() -> [Character] {
    var c: [Character] = []
    for char in self {
      c.append(char)
    }
    return c
  }
}

let rawInput = """
939
1789,37,47,1889
"""

func occurance(a: Int, b: Int, boffset: Int) -> (c: Int, d: Int) {
  var s = 1
  var realOffset = boffset
  while realOffset > b {
    realOffset -= b
  }
  while (true) {
    if a*s % b == (b - realOffset) {
      return (s, b)
    }
    s+=1
  }
}

func first(x:(c: Int, d: Int), y: (c: Int, d: Int)) -> Int {
  var c = 1
  var b = 1
  let gap = x.c - y.c
  while (true) {
    let r = c * y.d - b * x.d
    if r == gap {
      print(c)
      return c * y.d + y.c
    }
    if r < gap {
      if r + y.d < gap {
       c = (gap + b * x.d) / y.d - 1
      }
      c+=1
    }
    if r > gap {
      if r - x.d > gap {
        b = (c * y.d - gap) / x.d - 1
      }
      b+=1
    }
  }
}

let input = rawInput.lines()

var input2 = input[1].components(separatedBy: ",").enumerated().compactMap({ x in Int(x.1).flatMap({ (x.0,$0) }) })
let f  = input2[0]
input2 = Array(input2.dropFirst())

let base = f.1

let value = input2.reduce((0,1)) { (state, element) in
  let  t = (first(x: state, y: occurance(a: base, b: element.1, boffset: element.0)), state.1*element.1)
  print(t)
  return t
}

print(value.0 * base)

