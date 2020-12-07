import Foundation

extension String {
  func lines() -> [String] {
    self.components(separatedBy: "\n")
  }
}


let rawInput = """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
"""

struct Bag {
  let colour: String
  let number: Int
}
var input: [String: [Bag]] = [:]

rawInput.lines().forEach {
  let colourAndContents = $0.replacingOccurrences(of: "bags", with: "").replacingOccurrences(of: "bag", with: "").replacingOccurrences(of: ".", with: "").components(separatedBy: " contain")
  input[colourAndContents[0].trimmingCharacters(in: .whitespacesAndNewlines)] = colourAndContents[1].components(separatedBy: ",").compactMap { bag in
    Int(String(bag.dropFirst().first!)).flatMap { num in Bag(colour: String(bag.dropFirst(3).trimmingCharacters(in: .whitespacesAndNewlines)), number: num)}
  }
}

func containsColour(target: String, bag: String) -> Bool {
  let bags = input[bag]!
  if bags.count == 0 {
    return false
  }
  if bags.contains(where: { $0.colour == target }) {
    return true
  }

  return bags.reduce(false) { (contains, node) in
    contains || containsColour(target: target, bag: node.colour)
  }
}

let answer1 = input.keys.reduce(0) { (total, bag) in
  total + (containsColour(target: "shiny gold", bag: bag) ? 1 : 0)
}


func countContainedBags(nodes: [Bag]) -> Int {
  return nodes.reduce(0) { (total, node) in
    total + node.number + node.number * countContainedBags(nodes: input[node.colour]!)

  }
}

let answer2 = countContainedBags(nodes: input["shiny gold"]!)
