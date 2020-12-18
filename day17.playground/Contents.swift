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
.#.
..#
###
"""
let padding = 6
let inputSize = rawInput.lines().count
rawInput.lines().map { $0.characters() }


var matrix: [[[Character]]] = Array.init(repeating: Array.init(repeating: Array.init(repeating: ".", count: inputSize + padding * 2), count: inputSize + padding * 2), count: 1 + padding * 2)
//matrix[z][x][y]
for (y, line) in rawInput.lines().enumerated() {
  for (x, char) in line.characters().enumerated() {
    matrix[padding][x+6][y+6] = char
  }
}

var relativePosition = (-1...1).flatMap { z in (-1...1).flatMap { x in (-1...1).map { y in (z,x,y) } }}
relativePosition.removeAll { (z, x, y) in
  z == 0 && y == 0 && x == 0
}

func nextState(z: Int, x: Int, y: Int) -> Character {
  let activeNeighbours = relativePosition.reduce(0) { (total: Int, pos: (Int, Int, Int)) -> Int in
    return total + (matrix[pos.0 + z][pos.1 + x][pos.2 + y] == "#" ? 1 : 0)
  }
  if matrix[z][x][y] == "#" {
    return (2...3).contains(activeNeighbours) ? "#" : "."
  } else {
    return activeNeighbours == 3 ? "#" : "."
  }
}

for iteration in (1...6) {
  var workingMatrix = matrix
  let start = padding - iteration
  for z in (start..<iteration*2 + 1) {
    for x in (start..<iteration*2 + inputSize) {
      for y in (start..<iteration*2 + inputSize) {
        workingMatrix[z][x][y] = nextState(z: z, x: x, y: y)
      }
    }
  }
  matrix = workingMatrix
}
print(matrix[padding])

matrix.flatMap({ $0.flatMap { $0} }).reduce(0) { total, char in
  return total + (char == "#" ? 1 : 0)
}
