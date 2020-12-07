import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}

let rawInput = """
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
"""

let passInts = rawInput.lines().map {
  $0.reduce(0) { (total, char) in
    total<<1 + (["B", "R"].contains(char) ? 1 : 0)
  }
}

let answer1 = passInts.max()

let answer2 = ((passInts.min()! - 1)...).first(where: {
  !passInts.contains($0 + 1)
})! + 1
