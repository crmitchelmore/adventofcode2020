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
  func asInt32() -> UInt32 {
    return UInt32(strtoul(self, nil, 2))
  }
}

let rawInput = """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""
 var andMask = UInt64.max
 var orMask = UInt64.min
 var mem: [Int: UInt64] = [:]
 let newMem = rawInput.lines().reduce(into: mem) { (memory, line) in
  if line.contains("mask") {
    let mask = line.characters()
    andMask = UInt64.max
    orMask = UInt64.min
    mask.reversed().reduce(0) { (index, char) in
     if char == "1" {
       orMask += (1 << index)
     }
     if char == "0" {
       andMask -= (1 << index)
     }
     return index + 1
    }
  } else {
    let components = line.components(separatedBy: " = ")
    memory[Int(components[0].filter("0123456789".contains))!] = ((UInt64(components[1])! & andMask) | orMask)
  }
 }


 let answer1 = newMem.values.reduce(0, +)


 var memory: [UInt64: UInt64] = [:]

 func writeToMemory(mask: [UInt64], value: UInt64, memoryNumber: UInt64) {
  if mask.count == 0 {
    memory[memoryNumber] = value
    return
  }
  writeToMemory(mask: Array(mask.dropFirst()), value: value, memoryNumber: memoryNumber | mask[0])
  writeToMemory(mask: Array(mask.dropFirst()), value: value, memoryNumber: memoryNumber & (~mask[0]))
 }

 var maskWildCards: [UInt64] = []

 rawInput.lines().forEach { line in
  if line.contains("mask") {
    let mask = line.characters()
    orMask = UInt64.min
    maskWildCards = []
    mask.reversed().reduce(0) { (index, char) in
     if char == "1" {
       orMask += (1 << index)
     }
     if char == "X" {
      maskWildCards.append(1 << index)
     }
     return index + 1
    }
  } else {
    let components = line.components(separatedBy: " = ")
    writeToMemory(mask: maskWildCards, value: UInt64(components[1])!, memoryNumber: UInt64(components[0].filter("0123456789".contains))! | orMask)
  }
 }

let answer2 = memory.values.reduce(0, +)


