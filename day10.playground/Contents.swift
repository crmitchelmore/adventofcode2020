import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}


let rawInput = """
16
10
15
5
1
11
7
19
6
12
4
"""

let sortedNumbers = rawInput.lines().compactMap(Int.init).sorted()
let result = sortedNumbers.reduce((last: 0, ones: 0,  threes: 1)) { (state, next) in
  let difference = next - state.last
  return (next, state.ones + (difference == 1 ? 1 : 0), state.threes + (difference == 3 ? 1 : 0))
}

let answer1 = result.ones * result.threes

var numberOfVarients: [[Int]: Int] = [:]

func calculate(items: [Int], last: Int) -> Int {

  if items.count == 0 || !(items[0] <= last + 3) {
    return 0
  }

  if items.count == 1, last >= items[0]-3 {
    numberOfVarients[[last] + items] = 1
    return 1
  }

  if let n = numberOfVarients[[last] + items] {
    return n
  }
  let sum = calculate(items: Array(items.dropFirst()), last: last) +  calculate(items: Array(items.dropFirst()), last: items[0])

  numberOfVarients[[last] + items]  = sum

  return sum
}



let answer2 = calculate(items: sortedNumbers, last: 0)


