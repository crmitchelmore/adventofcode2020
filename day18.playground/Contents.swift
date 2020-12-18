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
1 + (2 * 3) + (4 * (5 + 6))
2 * 3 + (4 * 5)
5 + (8 * 3 + 9 + 3 * 4 * 3)
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
"""

let input = rawInput.lines().map {
  $0.replacingOccurrences(of: "(", with: "( ").replacingOccurrences(of: ")", with: " )").trimmingCharacters(in: .whitespaces)
}

enum Running {
  enum Op {
    case add
    case multiply
  }
  case op(Op)
  case calc(Int, Op)
  case num(Int)
  case none
  var num: Int? {
    if case .num(let n) = self {
      return n
    } else {
      return nil
    }
  }
  var isNotNone: Bool {
    switch self {
      case .none: return false
      default: return true
    }
  }
  func apply(next: Running) -> Running {
    switch (self, next) {
    case (.none, .num):
      return next
    case (let .num(val), let .op(op)):
      return .calc(val, op)
    case (let .calc(val, op), let .num(num)):
          switch op {
          case .add:
            return .num(val + num)
          case .multiply:
            return .num(val * num)
          }
    default:
      fatalError()
    }

  }
}
var plusPrecedesMultiply = false

func parseExpression(exp: String) -> Int {
  var parts = exp.components(separatedBy: " ")
  var running = Running.none
  if parts.count == 1 {
    return Int(parts[0])!
  }
  while parts.count > 0 {

    switch parts[0] {
    case "(":
      var open = 0
      for (index, char) in parts.enumerated() {
        if char == "(" {
          open += 1
        } else if char == ")" {
          open -= 1
        }
        if open == 0 {
          let num = parseExpression(exp: parts[1..<index].joined(separator: " "))
          if plusPrecedesMultiply, running.isNotNone, parts.count > 1, case let .calc(_, op) = running, op == .multiply {
            running = running.apply(next: .num(parseExpression(exp: (["\(num)"] + parts.dropFirst(index+1)).joined(separator: " "))))
            parts = []
          } else {
            running = running.apply(next: .num(num))
            parts = Array(parts.dropFirst(index+1))
          }
          break
        }
      }
    case "+":
      running = running.apply(next: .op(.add))
      parts = Array(parts.dropFirst())
    case "*":
      running = running.apply(next: .op(.multiply))
      parts = Array(parts.dropFirst())
    default:
      if let num = Int(parts[0]) {
        if plusPrecedesMultiply, running.isNotNone, parts.count > 1, case let .calc(_, op) = running, op == .multiply {
          running = running.apply(next: .num(parseExpression(exp: parts.joined(separator: " "))))
          parts = []
        } else {
          running = running.apply(next: .num(num))
          parts = Array(parts.dropFirst())
        }


      } else {
        fatalError()
      }
    }
  }
  return running.num!
}
let answer1 = input.reduce(0) { (total, next) in
  return total + parseExpression(exp: next)
}
plusPrecedesMultiply = true
let answer2 = input.reduce(0) { (total, next) in
  return total + parseExpression(exp: next)
}

print(answer2)

