import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")!
let rawtext = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
let lines = rawtext.components(separatedBy: "\r\n")
let text = rawtext.replacingOccurrences(of:"\r\n", with:"")

let width = lines[0].length
let height = lines.count
print ("size: \(width) x \(height)")

let offsets = [(-1, -1), (-1, 0), (-1, 1), (1, -1), (1, 0), (1, 1), (0, -1), (0, 1)]

var gears:[Int:[(Int, Int)]] = [:]

func getIdx(x: Int, y : Int) -> Int {
    return y * width + x
}

func getCharIdx(text: String, idx: Int) -> String.Index {
    return text.index(text.startIndex, offsetBy: idx)
}

func isAdjacent(x: Int, y: Int, num: Int, numIdx:Int) -> Bool{
    for offset in offsets {
        let newx = x + offset.0
        let newy = y + offset.1

        if (newy > 0 && newy < height && newx > 0 && newx < width) {
            let intIndex = getIdx(x:newx, y:newy);
            let index = text.index(text.startIndex, offsetBy: intIndex)
            if (!text[index].isNumber && text[index] != ".") {
                if (text[index] == "*") {
                    // add to dictionary
                    if (gears.keys.contains(intIndex)) {
                        if (!gears[intIndex]!.contains(where: {$0 == (num, numIdx)})) {
                            gears[intIndex]!.append((num, numIdx))
                        }
                    } else {
                        gears[intIndex] = [(num, numIdx)]
                    }
                }
                return true
            }
        }
    }
    return false;
}

func processDigit(x: Int, y: Int, num: Int, numIdx: Int) -> (Bool, Int) {
    var len = 0
    var isPartial = false

    while( x+len < width && text[getCharIdx(text:text, idx:getIdx(x:x+len, y:y))].isNumber) {
        if (isAdjacent(x:x+len, y:y, num:num, numIdx:numIdx)) {
            isPartial = true
        }
        len += 1
    }
    return (isPartial, len)
}

var pt1 = 0
var pt2 = 0

for y in 0..<lines.count {
    // extract all nums
    let nums = lines[y].components(separatedBy: CharacterSet.decimalDigits.inverted).filter{$0 != ""}//compactMap(Int.init)
    var x = 0
    var numsIdx = 0
    while x < lines[y].count {
        if (lines[y][getCharIdx(text:lines[y], idx:x)].isNumber) {
            let result = processDigit(x:x, y:y, num:Int(nums[numsIdx])!, numIdx:numsIdx)
            if (result.0) {
                pt1 += Int(nums[numsIdx])!
            }
            numsIdx += 1
            x += result.1
        } else {
            x += 1
        }
    }
}

print ("pt1: \(pt1)")

for (_, vals) in gears {
    if (vals.count == 2) {
        pt2 += vals[0].0 * vals[1].0
    }
}

print ("pt2: \(pt2)")
