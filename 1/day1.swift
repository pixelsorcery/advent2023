import Foundation

let nums:[String] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
let replacements:[String] = ["z0ero", "o1ne", "t2wo", "t3hree", "f4our", "f5ive", "s6ix", "s7even", "e8ight", "n9ine"]

func getFirstNum(str: String) -> Int {
    for c in str {
        if let first = Int(String(c)) {
            return first;
        }
    }
    return -1
}

func getLastNum(str: String) -> Int {
    for c in str.reversed() {
        if let last = Int(String(c)) {
            return last;
        }
    }
    return -1
}

func replaceNum(str: String) -> String {
    var result = str;
    for i in 0...9 {
        result = result.replacingOccurrences(of:nums[i], with: replacements[i])
    }
    return result
}

let path = Bundle.main.path(forResource: "input", ofType: "txt")!
let text = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
let lines = text.components(separatedBy:"\n")

var pt1 = 0
var pt2 = 0

for l in lines {
    let first = getFirstNum(str:l)
    let second = getLastNum(str:l)
    if (first > 0 && second > 0) {
        let num = first * 10 + second
        pt1 += num
    }

    let l2 = replaceNum(str:l)
    let first2 = getFirstNum(str:l2)
    let second2 = getLastNum(str:l2)
    if (first2 > 0 && second2 > 0) {
        let num = first2 * 10 + second2
        pt2 += num
    }
}

print("pt1: \(pt1)")
print("pt2: \(pt2)")


