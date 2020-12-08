import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}


let rawInput = """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"""

enum Command: String {
  case nop, acc, jmp
}

let input = rawInput.lines().map({ line -> (Command, Int) in
  let parts = line.components(separatedBy: " ")
  return (Command(rawValue: parts[0])!,(parts[1].first! == "+" ? 1 : -1) * Int(parts[1].dropFirst())!)
})

func run(input: [(Command, Int)]) -> (acc: Int, pos: Int) {
  var acc = 0
  var pos = 0
  var indexes = Set<Int>()
  while pos >= 0, pos <= input.count, !indexes.contains(pos){
    if pos == input.count {
      return (acc, pos)
    }
    indexes.insert(pos)
    switch input[pos] {
      case (.nop, _):
        pos += 1
      case (.jmp, let by):
        pos += by
    case (.acc, let by):
      pos += 1
      acc += by
    }
  }
  return (acc, pos)
}

let (acc, _) = run(input: input)
print("1: \(acc)")

for index in (0..<input.count) {
  var tempInput = input
  switch input[index] {
  case (.nop, let by):
    tempInput[index] = (.jmp, by)
  case (.jmp, let by):
    tempInput[index] = (.nop, by)
  case (.acc, _):
    continue
  }
  let (acc, pos) = run(input: tempInput)
  if pos == tempInput.count {
    print("2: \(acc)")
    break
  }
}



