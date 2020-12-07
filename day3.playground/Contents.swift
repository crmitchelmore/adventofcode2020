import Foundation
extension StringProtocol {
    subscript(offset: Int) -> String {
        "\(self[index(startIndex, offsetBy: offset)])"
    }
}
extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}

let rawInput = """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
"""

let map = rawInput.lines()
let width = map[0].count
let height = map.count

let answer1 = [(3, 1)].reduce(1) { (t, e) in
  var trees = 0
  var (x,y) = (0,0)
  let (dx, dy) = e
  while (y < height) {
    if (map[y][x%width] == "#") {
      trees += 1
    }
    x+=dx; y+=dy
  }
  return t * trees
}

let slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]

let answer2 = slopes.reduce(1) { (t, e) in
  var trees = 0
  var (x,y) = (0,0)
  let (dx, dy) = e
  while (y < height) {
    if (map[y][x%width] == "#") {
      trees += 1
    }
    x+=dx; y+=dy
  }
  return t * trees
}


