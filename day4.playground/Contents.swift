import Foundation
extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else { return false }
        let range = NSRange(location: 0, length: lhs.utf16.count)
        return regex.firstMatch(in: lhs, options: [], range: range) != nil
    }
}

let rawInput = """
pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719
"""

func validate(field: String) -> Bool {
  let parts = field.components(separatedBy: ":")
  let key = parts[0]; let valSring = parts[1]; let valInt = Int(parts[1])
  switch (key, valInt, valSring) {
  case ("byr", (1920...2002)?, _),
       ("iyr", (2010...2020)?, _),
       ("eyr", (2020...2030)?, _):
    return true
  case ("hgt", _, let h):
    if !(h ~= "^[0-9]{2,3}(in|cm)$") {
      return false
    }
    let range = h.contains("in") ? (59...76) : (150...193)
    let n = Int(h.replacingOccurrences(of: "in", with: "").replacingOccurrences(of: "cm", with: ""))!
    return range.contains(n)
  case ("hcl", _, let hcl):
    return hcl ~= "^#[a-f0-9]{6}$"
  case ("ecl", _, let ecl):
    return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].firstIndex(of: ecl) != nil
  case ("pid", _, let pid):
    return pid ~= "^[0-9]{9}$"
  default:
    return false
  }

}

let passports = rawInput.components(separatedBy: "\n\n")
let answer2 = passports.reduce(0) { (totalValid, passport) in
  let fields = passport.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
  return fields.filter({ validate(field: $0) }).count == 7 ? totalValid + 1 : totalValid
}
