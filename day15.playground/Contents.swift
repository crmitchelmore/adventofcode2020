import Foundation
let rawInput = """
6,4,12,1,20,0,16
"""
//
//0,3,6,0
var input = rawInput.components(separatedBy: ",").compactMap { Int($0) }

while input.count < 100 {
  let index = Array(input.dropLast().reversed()).firstIndex(of: input.last!)
  if let index = index {
    input.append(index + 1)
  } else {
    input.append(0)
  }
}
print("1: \(input.last!)")

input = rawInput.components(separatedBy: ",").compactMap { Int($0) }
var position = 1
var lastPositions: [Int: Int] = [:]
for e in input {
  print(e)
  lastPositions[e] = position
  position += 1
}


// Run this in Xcode Proper otherwise. It will take long time in playground
var lastElement = input.last!

while position <= 30_000_000 {
  let lastLastElement = lastElement
  if let last = lastPositions[lastElement] {
    let difference = position - last - 1
    lastElement = difference
  } else {
    lastElement = 0
  }
  lastPositions[lastLastElement] = position - 1
  if position % 1_000_000 == 0 {
    print(position)
  }
//  print(lastElement)
  position += 1
}

print("2: \(lastElement)")
