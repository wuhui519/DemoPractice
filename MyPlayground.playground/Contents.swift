import UIKit

var str = "Hello, playground"
let range = NSMakeRange(0, str.count)
let range2 = NSRangeFromString(str)



var array:[Any] = [1, 2, 3, 4, 5, "abc"]
array[0]
type(of: array)
var array1: [String] = []
array1.append("abc")
var array2 = [String]()
array2.append("efg")
array1 + array2
for item in array {
    print(item)
}

var dict:[String: Any] = ["name":"wuhui", "school":"HNU", "age":34]
dict["name"]
dict["age"]
for item in dict {
    print(item.value)
}

if str == "Hello, playground" {
    print("yes")
}
else {
    print("no")
}

for i in 0..<9 {
    print("\(i) * 10 = \(i * 10)")
}

var people = ["players", "haters", "heart-breakers", "fakers"]
var actions = ["play", "hate", "break", "fake"]
for i in 0..<people.count {
    var item = "\(people[i]) gonna "
    for _ in 1...5 {
        item += "\(actions[i]) ";
    }
    print(item)
}

let liveAlbums = 1
switch liveAlbums {
case 0...1:
    print("mini mouse")
    fallthrough
case 2...4:
    print("boboyle")
    fallthrough
case 5:
    print("gorilla")
default:
    print("knight")
}

func favoriteAlbum(name: String) {
    print("My favorite Album is \(name)")
}
favoriteAlbum(name: "Fearless")

func albumReleased(year: Int) -> String? {
    switch year {
    case 2006:
        return "Fever Pitch"
    default:
        return nil
    }
}
// optionals
if let optionals = albumReleased(year: 2006) {
    print("optionals: \(optionals)")
}
// force unwrapping optionals
let force = albumReleased(year: 2006)!
print("force unwrapping optionals: \(force)")
// optional chaining
let chain = albumReleased(year: 2006)?.uppercased()
print("optional chain: \(chain)")
// nil coalescing operator
let result = albumReleased(year: 2007) ?? "unkowon"
print("nil coalescing: \(result.uppercased())")

// Enums with additional values
enum WeatherType {
    case sunny, rainy, stormy, snowy, cloudy
    case windy(speed: Int)
}
func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sunny:
        return nil
    case .windy(let speed) where speed < 5:
        return "meh"
    case .cloudy, .snowy, .windy:
        return "dislike"
    default:
        return "hate"
    }
}
getHaterStatus(weather: .windy(speed: 3))
`
struct Person {
    var clothes: String
    var shoes: String
    func describe() {
        print("I'm wearing \(self.clothes) and \(self.shoes)")
    }
}
let programmer = Person(clothes: "T-Shirts", shoes: "sneaks")
let officeLady = Person(clothes: "short skirts", shoes: "high heels")
print(officeLady.clothes + ", " + officeLady.shoes)

var youngLady = officeLady
youngLady.shoes = "flip flops"
officeLady.describe()
youngLady.describe()

// Structs & Classes
//1. You don't get an automatic memberwise initializer for your classes; you need to write your own.
//2. You can define a class as being based off another class, adding any new things you want.
//3. When you create an instance of a class it’s called an object. If you copy that object, both copies point at the same data by default – change one, and the copy changes too.
class People {
    // property observers
    var clothes: String {
        willSet {
            print("I'm changing clothes from \(clothes) to \(newValue)")
        }
        didSet {
            print("I've changed clothes from \(oldValue) to \(clothes)")
        }
    }
    var shoes: String
    // computed properties
    var outfit: String {
        get {
            return "\(clothes) and \(shoes)"
        }
    }
    // static property
    static var favoriteColor = "Red"
    // access control
    private var name: String = "Faye"
    
    init(clothes: String, shoes: String) {
        self.clothes = clothes
        self.shoes = shoes
    }
    
    func describe() {
        print("I'm wearing \(clothes) and \(shoes)")
    }
}
let man = People(clothes: "suits", shoes: "leather shoes")
man.clothes = "blouses"
man.describe()
man.outfit
People.favoriteColor
class Boy: People {
    var beard: String
    init(clothes: String, shoes: String, beard: String) {
        self.beard = beard
        super.init(clothes: clothes, shoes: shoes)
    }
    override func describe() {
        super.describe()
        print("I also have \(beard)")
    }
}
var boy = Boy(clothes: "jeans", shoes: "Air Jordan", beard: "mustache")
boy.describe()

// optional downcasting & force downcasting
var twoPeople = [man, boy]
if let aBoy = twoPeople.last as? Boy {
    aBoy.beard
}
for item in twoPeople as? [Boy] ?? [Boy]() {
    item.describe()
}

// closures
let view = UIView()
UIView.animate(withDuration: 0.5, animations: {
    view.alpha = 0
}, completion:{(finish) in
    view.alpha = 1
})

