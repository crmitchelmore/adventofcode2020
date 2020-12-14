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
F10
N3
F7
R90
F11
"""


let endPosition = rawInput.lines().map({ ($0.first!, Int($0.dropFirst())!)}).reduce((shipx: 0, shipy: 0, wayx: 10, wayy: 1)) { (position, movement) in
  print(position)
  switch movement {
  case ("N", let size):
    return (position.shipx, position.shipy, position.wayx, position.wayy + size)
  case ("S", let size):
    return (position.shipx, position.shipy, position.wayx, position.wayy - size)
  case ("E", let size):
    return (position.shipx, position.shipy, position.wayx + size, position.wayy)
  case ("W", let size):
    return (position.shipx, position.shipy, position.wayx - size, position.wayy)
  case ("R", let angle):
    switch (angle % 360) {
    case 0:
      return (position.shipx, position.shipy, position.wayx, position.wayy)
    case 90:
      return (position.shipx, position.shipy, position.wayy, -position.wayx)
    case 180:
      return (position.shipx, position.shipy, -position.wayx, -position.wayy)
    case 270:
      return (position.shipx, position.shipy, -position.wayy, position.wayx)
    default:
      fatalError()
    }
  case ("L", let angle):
    switch (angle % 360) {
    case 0:
      return (position.shipx, position.shipy, position.wayx, position.wayy)
    case 90:
      return (position.shipx, position.shipy, -position.wayy, position.wayx)
    case 180:
      return (position.shipx, position.shipy, -position.wayx, -position.wayy)
    case 270:
      return (position.shipx, position.shipy, position.wayy, -position.wayx)
    default:
      fatalError()
    }
  case ("F", let size):
    return (position.shipx + size*position.wayx, position.shipy + size*position.wayy, position.wayx, position.wayy)
  default:
    fatalError()
  }
}
print(endPosition)
let answer2 = abs(endPosition.shipx) + abs(endPosition.shipy)
