import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}


let rawInput = """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
"""

let preamble = 5
let previous = 5

let input = rawInput.lines().compactMap(Int.init)

var invalidNumber = 0
for index in (preamble..<input.count) {
  let target = input[index]
  let scope = input[(index-previous)..<index]
  let valid = scope.reduce(false) { (hasSumToTarget, candidate) in
    return hasSumToTarget || (candidate * 2 != target && scope.contains(target - candidate))
  }
  if !valid {
    invalidNumber = target
    break
  }
}

print("1 \(invalidNumber)")

for (index, value) in input.enumerated() {
  var total = value
  for second in (index+1)..<input.count {
    total += input[second]
    if total == invalidNumber {
      let range = input[(index)..<second]
      print("2: \(range.min()! + range.max()!)")
      break
    }

  }
}
