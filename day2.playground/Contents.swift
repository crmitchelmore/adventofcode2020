import Foundation
extension StringProtocol {
    func char(_ i: Int) -> Character {
        self[index(startIndex, offsetBy: i)]
    }
}
extension Bool {
  var int: Int {
    self ? 1 : 0
  }
}
extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}

let rawInput = """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

let answer1 = rawInput.lines().reduce(0) { (totalValid, line) in
  let parts = line.components(separatedBy: " ")
  let rangeParts = parts[0].components(separatedBy: "-")
  let range = (Int(rangeParts[0])!...Int(rangeParts[1])!)
  let numberOfTargetCharacter = parts[2].filter({ $0 == parts[1].first!}).count
  return totalValid + range.contains(numberOfTargetCharacter).int
}

let answer2 = rawInput.lines().reduce(0) { (totalValid, line) in
  let parts = line.components(separatedBy: " ")
  let numbers = parts[0].components(separatedBy: "-")
  let valid = (parts[2].char(Int(numbers[0])!-1) == parts[1].first!) != (parts[2].char(Int(numbers[1])!-1) == parts[1].first!)
  return totalValid + valid.int
}



