import Foundation

let path = Bundle.main.path(forResource: "test", ofType: "txt")!
let rawtext = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
let lines = rawtext.components(separatedBy: "\r\n")
var pt1 = 0
var pt2 = 0
for line in lines {
    let nums = line.components(separatedBy: [":", "|"])
    let w = Set(nums[1].components(separatedBy: .whitespaces).map{$0.trimmingCharacters(in: .whitespaces)}.compactMap{Int($0)})
    let n = Set(nums[2].components(separatedBy: .whitespaces).map{$0.trimmingCharacters(in: .whitespaces)}.compactMap{Int($0)})
    let u = w.intersection(n)
    if (u.count > 0) {
        pt1 += Int(pow(2.0, Double(u.count-1)))
    }
}

var memo:[Int:Int] = [:]


print ("pt1: \(pt1)")
print ("pt2: \(pt2)")