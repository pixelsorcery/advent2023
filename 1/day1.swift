import Foundation

let nums:[String] = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

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

func getFirstNum2(str: String) -> Int {

    return -1
}

func getLastNum2(str: String) -> Int {
    return -1
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

    let first2 = getFirstNum2(str:l)
    let second2 = getLastNum2(str:l)
    if (first > 0 && second > 0) {
        let num = first2 * 10 + second2
        pt2 += num
    }
    let index = l.index(l.startIndex, offsetBy: 0)
    print("\(l[index])")
}

print("pt1: \(pt1)")
print("pt2: \(pt2)")


