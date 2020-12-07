import Foundation
extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}

let rawInput = """
abc

a
b
c

ab
ac

a
a
a
a

b
"""


let groups = rawInput.components(separatedBy: "\n\n")
groups.reduce(0, { total, group in
  let firstGroup = group.lines()[0].map(String.init)
  return total + group.lines()
    .reduce(Set(firstGroup), { (r, line ) in
      return Set(line.map(String.init)).union(r)
    }).count
})
