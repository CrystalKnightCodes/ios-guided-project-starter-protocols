import Foundation

//: # Protocols
//: Protocols are, as per Apple's definition in the _Swift Programming Language_ book:
//:
//: "... a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol."
//:
//: The below example shows a protocol that requires conforming types have a particular property defined.
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let dimitri = Person(fullName: "Dimitri Bouniol")
let hector = Person(fullName: "Hector Villasano")

class Starship: FullyNamed {
var prefix: String?
var name: String

    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
var fullName: String {
/*    var validPrefix: String
    if prefix != nil {
        validPrefix = prefix!
    } else {
        validPrefix = ""
    }
    return validPrefix + " " + name
 */
    return (prefix != nil ? prefix! + " ": "") + " " + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
var firefly = Starship(name: "Firefly")
//: Protocols can also require that conforming types implement certain methods.
protocol GeneratesRandomNumbers {
    func random() -> Int
    }
class OneThroughTen: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)
    }
}

let rand = OneThroughTen()

rand.random()

extension Starship: Equatable {
    public static func == (lhs: Starship, rhs: Starship) -> Bool {
        if lhs.fullName == rhs.fullName {
            return true
        } else {
        return false
        }
        // return lhs.fullName == rhs.fullName
    }
}
// if a == b...
//
//Starship == (lhs: a, rhs: b)
    
        if ncc1701 == firefly {
            print("Same starship!")
        } else {
            print("Not the same Starship!")
        }

//: ## Protocols as Types

class Dice {
    let sides: Int
    let generator: GeneratesRandomNumbers
    init(sides: Int, generator: GeneratesRandomNumbers) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return (generator.random() % sides) + 1
    }
}

var d6 = Dice(sides: 6, generator: OneThroughTen())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}

class EvenThroughTwenty: GeneratesRandomNumbers {
    func random() -> Int {
        return Int.random(in: 1...10)*2 - 1
    }
}

var d6AlwaysEven = Dice(sides: 6, generator: EvenThroughTwenty())

