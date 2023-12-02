import Foundation

let path = Bundle.main.path(forResource: "input", ofType: "txt")!
let text = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
let lines = text.components(separatedBy: "\r\n")

let limits:[Int] = [12, 13, 14]

enum Block : Int {
    case red = 0, green, blue
}

var pt1 = 0
var pt2 = 0

for idx in 0..<100 {
    let results = lines[idx].components(separatedBy:":")[1]
    .components(separatedBy:[",", ";"])
    .map{$0.trimmingCharacters(in: .whitespaces)}

    let games = lines[idx].components(separatedBy:":")[1]
    .components(separatedBy:[";"])
    .map{$0.trimmingCharacters(in: .whitespaces)}

    var failed = false
    for color in results {
        let amtColor = color.components(separatedBy: " ")
        let amt = Int(amtColor[0])!
        let color = amtColor[1].trimmingCharacters(in: ["\r"])
        print("\(amtColor) \(amt) \(color)")

        switch(color) {
            case "red":
                if (amt > limits[Block.red.rawValue]){
                    failed = true
                }
            case "green":
                if (amt > limits[Block.green.rawValue]){
                    failed = true
                }
            case "blue":
                if (amt > limits[Block.blue.rawValue]){
                    failed = true
                }
            default:
                print("parse error")
        }
    }

    if (!failed) {
        pt1 += (idx + 1)
    }

    failed = false

    var mins:[Int] = [0, 0, 0]
    for game in games {
        let gameResults = game.components(separatedBy:[","])
        .map{$0.trimmingCharacters(in: .whitespaces)}
        for color in gameResults {
            let amtColor = color.components(separatedBy: " ")
            let amt = Int(amtColor[0])!
            let color = amtColor[1]
            switch(color) {
                case "red":
                    if (amt > mins[Block.red.rawValue]){
                        mins[Block.red.rawValue] = amt
                    }
                case "green":
                    if (amt > mins[Block.green.rawValue]){
                        mins[Block.green.rawValue] = amt
                    }
                case "blue":
                    if (amt > mins[Block.blue.rawValue]){
                        mins[Block.blue.rawValue] = amt
                    }
                default:
                    print("parse error")
            }
        }
    }

    pt2 += mins[0] * mins[1] * mins[2];
    mins = [0, 0, 0]
}

print ("pt1: \(pt1)")
print ("pt2: \(pt2)")