import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}
let rawInput = """
1721
979
366
299
675
1456
"""
let target = 2020
let input = rawInput.lines().compactMap(Int.init)
let result = input.first { input.contains(target-$0) }
print("1: \(result! * (target-result!))")

for (index, value) in input.enumerated() {
  let availableElements = input[(index+1)...]
  if let result = availableElements.first(where: { availableElements.contains(target-value-$0) }) {
    print("2: \(result * value * (target - result - value))")
    break
  }
}
